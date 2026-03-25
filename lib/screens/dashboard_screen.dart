import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Função para deslogar do Supabase
  Future<void> _fazerLogout() async {
    await Supabase.instance.client.auth.signOut();
    
    // Volta para a tela de login apagando o histórico
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  // Cores do Tema
  static const backgroundColor = Color(0xFF080A0F);
  static const surfaceColor = Color(0xFF111318);
  static const orangeThemeColor = Color(0xFFF97316);
  static const textSecondaryColor = Color(0xFF94A3B8);
  static const borderColor = Color(0xFF2A2D3E);

  @override
  Widget build(BuildContext context) {
    final userEmail = Supabase.instance.client.auth.currentUser?.email?.split('@').first ?? 'Usuário';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- HEADER SUPERIOR ---
                _buildHeader(userEmail),
                
                const SizedBox(height: 24),
                
                // --- TÍTULO E BOTÃO NOVA IT ---
                _buildTitleSection(),
                
                const SizedBox(height: 20),
                
                // --- CAMPO DE BUSCA ---
                _buildSearchField(),
                
                const SizedBox(height: 24),
                
                // --- GRID DE MÉTRICAS ---
                _buildMetricsGrid(),
                
                const SizedBox(height: 24),
                
                // --- CRITICIDADE DAS ITs ---
                _buildCriticalitySection(),
                
                const SizedBox(height: 24),
                
                // --- GERÊNCIA DE PROCESSOS ---
                _buildProcessesSection(),
                
                const SizedBox(height: 80), // Espaço para o bottom nav
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Header com logo, notificação e avatar
  Widget _buildHeader(String userEmail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo AIONS System
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: orangeThemeColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AIONS System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'v8.2.5 Gerenciamento Eficiente',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        
        // Notificação e Avatar
        Row(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: orangeThemeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _fazerLogout,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: orangeThemeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Título "Dashboard de ITs" com botão "+ Nova IT"
  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Dashboard de ITs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A8A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.add, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Nova IT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Campo de Busca
  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: textSecondaryColor, size: 20),
          SizedBox(width: 12),
          Text(
            'Buscar ITs...',
            style: TextStyle(
              color: textSecondaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Grid de Métricas (4 cards)
  Widget _buildMetricsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: const [
        MetricCard(
          title: 'Total de ITs',
          value: '12',
          icon: Icons.description_outlined,
          iconColor: Color(0xFF3B82F6),
        ),
        MetricCard(
          title: 'Publicadas',
          value: '6',
          icon: Icons.check_circle_outline,
          iconColor: Color(0xFF22C55E),
        ),
        MetricCard(
          title: 'Em Aprovação',
          value: '1',
          icon: Icons.access_time,
          iconColor: Color(0xFFEAB308),
        ),
        MetricCard(
          title: 'Descontinuadas',
          value: '1',
          icon: Icons.cancel_outlined,
          iconColor: Color(0xFFEF4444),
        ),
      ],
    );
  }

  // Seção de Criticidade das ITs
  Widget _buildCriticalitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: orangeThemeColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Criticidade das ITs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Barra Alta (Vermelho)
          _buildCriticalityBar('Alta', 6, const Color(0xFFEF4444)),
          const SizedBox(height: 12),
          
          // Barra Méd (Amarelo)
          _buildCriticalityBar('Méd', 3, const Color(0xFFEAB308)),
          const SizedBox(height: 12),
          
          // Barra Bx (Verde)
          _buildCriticalityBar('Bx', 3, const Color(0xFF22C55E)),
        ],
      ),
    );
  }

  // Barra individual de criticidade
  Widget _buildCriticalityBar(String label, int value, Color color) {
    // Calcula a largura proporcional (total = 12 ITs)
    final double fraction = value / 12.0;
    
    return Row(
      children: [
        // Label
        SizedBox(
          width: 40,
          child: Text(
            label,
            style: const TextStyle(
              color: textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        
        // Barra de progresso
        Expanded(
          child: Stack(
            children: [
              // Background da barra
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              // Barra preenchida
              FractionallySizedBox(
                widthFactor: fraction,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Valor
        SizedBox(
          width: 20,
          child: Text(
            value.toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Seção de Gerência de Processos
  Widget _buildProcessesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Gerência de Processos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Processo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Placeholder para a área de processos
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: const Center(
            child: Text(
              'Área de processos',
              style: TextStyle(
                color: textSecondaryColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.grid_view_rounded, 'Home', 0),
              _buildNavItem(Icons.show_chart, 'Fluxo', 1),
              _buildNavItem(Icons.message_outlined, 'Agente', 2),
              _buildNavItem(Icons.description_outlined, 'ITs', 3),
              _buildNavItem(Icons.person_outline, 'Perfil', 4),
            ],
          ),
        ),
      ),
    );
  }

  // Item individual do bottom navigation
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? orangeThemeColor : textSecondaryColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? orangeThemeColor : textSecondaryColor,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: orangeThemeColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// COMPONENTE DOS CARDS DE MÉTRICA
// --------------------------------------------------------------------------
class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF111318),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A2D3E), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}