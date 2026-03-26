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
  
  // Controles de estado independentes para ITs e Processos
  String _selectedITCard = 'total'; 
  String _selectedProcessCard = 'total'; 

  // ============================================================================
  // PALETA DE CORES GLOBAL (DESIGN SYSTEM PIXEL PERFECT)
  // ============================================================================
  static const backgroundColor = Color(0xFF0C0E14);
  static const surfaceColor = Color(0xFF141720);
  static const surface2Color = Color(0xFF1C2030);
  static const borderColor = Color(0xFF252A3A);

  static const orange = Color(0xFFF97316);
  static const blue = Color(0xFF6366F1);
  static const green = Color(0xFF22C55E);
  static const yellow = Color(0xFFEAB308);
  static const red = Color(0xFFEF4444);
  static const purple = Color(0xFFA855F7);
  static const textSecondaryColor = Color(0xFF8892A4);

  // ============================================================================
  // DADOS DOS PAINÉIS DE ITs
  // ============================================================================
  final Map<String, Map<String, dynamic>> detailPanelsIT = {
    'total': {
      'title': 'Detalhamento por Setor — Total de ITs',
      'sub': '12 ITs em 5 setores',
      'bars': [
        {'label': 'Operacional', 'val': 6, 'pct': '50%', 'color': purple},
        {'label': 'Depto Pessoal', 'val': 2, 'pct': '17%', 'color': green},
        {'label': 'RH', 'val': 2, 'pct': '17%', 'color': textSecondaryColor},
        {'label': 'SESMT', 'val': 1, 'pct': '8%', 'color': const Color(0xFF06B6D4)},
        {'label': 'Compras', 'val': 1, 'pct': '8%', 'color': yellow},
      ],
    },
    'publicadas': {
      'title': 'Detalhamento por Setor — ITs Publicadas',
      'sub': '6 ITs em 3 setores',
      'bars': [
        {'label': 'Operacional', 'val': 4, 'pct': '67%', 'color': purple},
        {'label': 'SESMT', 'val': 1, 'pct': '17%', 'color': const Color(0xFF06B6D4)},
        {'label': 'Depto Pessoal', 'val': 1, 'pct': '17%', 'color': green},
      ],
    },
    'aprovacao': {
      'title': 'Fila de Aprovação por Etapa',
      'sub': 'Onde estão paradas as 2 ITs pendentes?',
      'bars': [
        {'label': 'Auditoria', 'val': 2, 'pct': '100%', 'color': yellow},
      ],
    },
    'descontinuadas': {
      'title': 'Detalhamento por Setor — Descontinuadas',
      'sub': '1 IT em 1 setor',
      'bars': [
        {'label': 'Operacional', 'val': 1, 'pct': '100%', 'color': purple},
      ],
    },
    'intersetoriais': {
      'title': 'Detalhamento por Setor — ITs Intersetoriais',
      'sub': '4 ITs em 3 setores',
      'bars': [
        {'label': 'Operacional', 'val': 2, 'pct': '50%', 'color': purple},
        {'label': 'Depto Pessoal', 'val': 1, 'pct': '25%', 'color': green},
        {'label': 'RH', 'val': 1, 'pct': '25%', 'color': textSecondaryColor},
      ],
    },
    'financeiro': {
      'title': 'Detalhamento — Envolvimento Financeiro',
      'sub': '3 ITs em 2 setores',
      'bars': [
        {'label': 'Operacional', 'val': 2, 'pct': '67%', 'color': purple},
        {'label': 'Compras', 'val': 1, 'pct': '33%', 'color': yellow},
      ],
    },
    'criticidade': {
      'title': 'Detalhamento por Criticidade (ITs)',
      'sub': 'Distribuição de ITs por nível de risco',
      'bars': [
        {'label': 'Alta', 'val': 6, 'pct': '50%', 'color': red},
        {'label': 'Média', 'val': 3, 'pct': '25%', 'color': yellow},
        {'label': 'Baixa', 'val': 3, 'pct': '25%', 'color': green},
      ],
    },
  };

  // ============================================================================
  // DADOS DOS PAINÉIS DE PROCESSOS
  // ============================================================================
  final Map<String, Map<String, dynamic>> detailPanelsProcess = {
    'total': {
      'title': 'Detalhamento por Setor — Total de Processos',
      'sub': '12 Processos mapeados',
      'bars': [
        {'label': 'Operacional', 'val': 6, 'pct': '50%', 'color': purple},
        {'label': 'T.I', 'val': 3, 'pct': '25%', 'color': const Color(0xFF8B5CF6)},
        {'label': 'Financeiro', 'val': 3, 'pct': '25%', 'color': green},
      ],
    },
    'publicadas': { 'title': 'Processos Publicados', 'sub': 'Nenhum processo publicado', 'bars': [] },
    'aprovacao': { 'title': 'Em Aprovação', 'sub': 'Nenhum processo pendente', 'bars': [] },
    'descontinuadas': { 'title': 'Descontinuados', 'sub': 'Nenhum processo descontinuado', 'bars': [] },
    'intersetoriais': {
      'title': 'Processos Intersetoriais',
      'sub': '11 Processos em 2 setores',
      'bars': [
        {'label': 'Operacional', 'val': 6, 'pct': '54%', 'color': purple},
        {'label': 'Financeiro', 'val': 5, 'pct': '46%', 'color': green},
      ],
    },
    'financeiro': {
      'title': 'Processos Financeiros',
      'sub': '7 Processos em 1 setor',
      'bars': [
        {'label': 'Financeiro', 'val': 7, 'pct': '100%', 'color': green},
      ],
    },
    'criticidade': {
      'title': 'Detalhamento por Criticidade (Processos)',
      'sub': 'Distribuição de Processos por nível de risco',
      'bars': [
        {'label': 'Alta', 'val': 11, 'pct': '92%', 'color': red},
        {'label': 'Média', 'val': 1, 'pct': '8%', 'color': yellow},
        {'label': 'Baixa', 'val': 0, 'pct': '0%', 'color': green},
      ],
    },
  };

  Future<void> _fazerLogout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

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
                _buildHeader(userEmail),
                const SizedBox(height: 32),
                
                // --- SEÇÃO 1: DASHBOARD DE ITs ---
                _buildSectionTitle('Dashboard de ITs', 'Visão geral das Instruções de Trabalho', 'Nova IT'),
                const SizedBox(height: 24),
                _buildMetricsGrid(isIT: true),
                const SizedBox(height: 24),
                _buildDetailPanel(detailPanelsIT, _selectedITCard),
                
                const SizedBox(height: 40),
                const Divider(color: borderColor, thickness: 1),
                const SizedBox(height: 40),

                // --- SEÇÃO 2: GERÊNCIA DE PROCESSOS ---
                _buildSectionTitle('Gerência de Processos', 'Visão geral dos Processos do Sistema', 'Novo Processo'),
                const SizedBox(height: 24),
                _buildMetricsGrid(isIT: false),
                const SizedBox(height: 24),
                _buildDetailPanel(detailPanelsProcess, _selectedProcessCard),

                const SizedBox(height: 40),
                const Divider(color: borderColor, thickness: 1),
                const SizedBox(height: 40),

                // --- SEÇÃO 3: SUGESTÕES DE VERIFICAÇÃO (NOVO) ---
                _buildSugestoesVerificacao(),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader(String userEmail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Colocamos o Expanded aqui para o texto nunca vazar da tela!
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, ${userEmail.isNotEmpty ? userEmail[0].toUpperCase() + userEmail.substring(1) : ''}!',
                style: const TextStyle(fontFamily: 'Syne', color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, // Bota "..." se o nome for gigante
              ),
              const SizedBox(height: 4),
              const Text(
                'Acompanhe o status dos processos', 
                style: TextStyle(fontFamily: 'DMSans', color: textSecondaryColor, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8), // Espaço seguro
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: const Stack(
                children: [
                  Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(radius: 6, backgroundColor: orange),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: _fazerLogout,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'U',
                    style: const TextStyle(fontFamily: 'Syne', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String subtitle, String btnLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontFamily: 'Syne', color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontFamily: 'DMSans', color: textSecondaryColor, fontSize: 12)),
            ],
          ),
        ),
        // Botão principal estilizado fielmente ao Figma
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: blue, // Usando a variável da paleta
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0, // Removendo sombra padrão do Material
          ),
          onPressed: () {},
          icon: const Icon(Icons.add, size: 16, color: Colors.white),
          label: Text(
            btnLabel,
            style: const TextStyle(
              fontFamily: 'Syne',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid({required bool isIT}) {
    String selectedKey = isIT ? _selectedITCard : _selectedProcessCard;
    
    void onSelect(String key) {
      setState(() {
        if (isIT) { _selectedITCard = key; } else { _selectedProcessCard = key; }
      });
    }

    String valTotal = isIT ? '12' : '12';
    String valPub   = isIT ? '6' : '0';
    String valAprov = isIT ? '2' : '0';
    String valDesc  = isIT ? '1' : '0';
    String valInter = isIT ? '4' : '11';
    String valFin   = isIT ? '3' : '7';
    int cAlta = isIT ? 6 : 11;
    int cMed  = isIT ? 3 : 1;
    int cBaixa = isIT ? 3 : 0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildMetricCard('Total', valTotal, Icons.description_outlined, blue, 'total', selectedKey, onSelect)),
            const SizedBox(width: 12),
            Expanded(child: _buildMetricCard('Publicadas', valPub, Icons.check_circle_outline, green, 'publicadas', selectedKey, onSelect)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMetricCard('Em Aprovação', valAprov, Icons.access_time, yellow, 'aprovacao', selectedKey, onSelect)),
            const SizedBox(width: 12),
            Expanded(child: _buildMetricCard('Descontinuadas', valDesc, Icons.cancel_outlined, red, 'descontinuadas', selectedKey, onSelect)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMetricCard('Intersetoriais', valInter, Icons.shuffle, purple, 'intersetoriais', selectedKey, onSelect)),
            const SizedBox(width: 12),
            Expanded(child: _buildMetricCard('Financeiro', valFin, Icons.attach_money, green, 'financeiro', selectedKey, onSelect)),
          ],
        ),
        const SizedBox(height: 12),
        _buildCriticidadeCard(cAlta, cMed, cBaixa, 'criticidade', selectedKey, onSelect),
      ],
    );
  }

  // --- CARD EXATO COMO DEFINIDO NO FIGMA ---
  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
    String cardKey,
    String selectedKey,
    Function(String) onSelect,
  ) {
    final isSelected = selectedKey == cardKey;

    return GestureDetector(
      onTap: () => onSelect(cardKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? iconColor : borderColor,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: iconColor.withOpacity(0.25),
                    blurRadius: 12,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Syne',
                fontSize: 28,
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'DMSans',
                fontSize: 11,
                color: textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- CARD DE CRITICIDADE COM ANIMAÇÃO ---
  Widget _buildCriticidadeCard(int alta, int med, int baixa, String cardKey, String selectedKey, Function(String) onSelect) {
    bool isSelected = selectedKey == cardKey;
    Color iconColor = orange;

    return GestureDetector(
      onTap: () => onSelect(cardKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? iconColor : borderColor, width: isSelected ? 1.5 : 1),
          boxShadow: isSelected
              ? [ BoxShadow(color: iconColor.withOpacity(0.25), blurRadius: 12, spreadRadius: 1) ]
              : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Criticidade',
                    style: TextStyle(fontFamily: 'DMSans', color: isSelected ? Colors.white : textSecondaryColor, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  _buildMiniBar('Alta', alta, red),
                  _buildMiniBar('Méd', med, yellow),
                  _buildMiniBar('Baixa', baixa, green),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(color: iconColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.warning_amber_rounded, color: iconColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // --- BARRAS DE CRITICIDADE ANIMADAS EXATAS ---
  Widget _buildMiniBar(String label, int value, Color color) {
    final double percentage = (value / 12).clamp(0.0, 1.0);

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 35,
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0, end: percentage),
                builder: (context, valueAnim, _) {
                  return Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: surface2Color,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: valueAnim,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.4),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value.toString(),
              style: const TextStyle(
                fontFamily: 'Syne',
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  // --- PAINEL DINÂMICO (COM ANIMAÇÕES) ---
  Widget _buildDetailPanel(Map<String, Map<String, dynamic>> sourceMap, String selectedKey) {
    final panelData = sourceMap[selectedKey]!;
    final List<dynamic> bars = panelData['bars'];
    
    int total = bars.fold(0, (sum, bar) => sum + (bar['val'] as int));
    if (total == 0) total = 1;

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
              const Icon(Icons.bar_chart, color: blue, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  panelData['title'],
                  style: const TextStyle(fontFamily: 'Syne', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(panelData['sub'], style: const TextStyle(fontFamily: 'DMSans', color: textSecondaryColor, fontSize: 12)),
          const SizedBox(height: 24),
          
          if (bars.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Nenhum dado encontrado para este filtro.', style: TextStyle(fontFamily: 'DMSans', color: textSecondaryColor, fontStyle: FontStyle.italic)),
              ),
            )
          else
            ...bars.map((bar) {
              final double fraction = (bar['val'] as int) / total;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildSectorBar(bar['label'], bar['val'], bar['pct'], bar['color'], fraction),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildSectorBar(String label, int value, String pct, Color color, double fraction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontFamily: 'DMSans', color: Color(0xFFE2E8F0), fontSize: 13, fontWeight: FontWeight.w600)),
            Row(
              children: [
                Text(pct, style: const TextStyle(fontFamily: 'DMSans', color: textSecondaryColor, fontSize: 12)),
                const SizedBox(width: 8),
                Text(value.toString(), style: const TextStyle(fontFamily: 'Syne', color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0, end: fraction.clamp(0.0, 1.0)),
          builder: (context, valueAnim, _) {
            return Stack(
              children: [
                Container(height: 8, decoration: BoxDecoration(color: surface2Color, borderRadius: BorderRadius.circular(4))),
                FractionallySizedBox(
                  widthFactor: valueAnim,
                  child: Container(
                    height: 8, 
                    decoration: BoxDecoration(
                      color: color, 
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [ BoxShadow(color: color.withOpacity(0.3), blurRadius: 6) ]
                    )
                  ),
                ),
              ],
            );
          }
        ),
      ],
    );
  }

  // --- SUGESTÕES DE VERIFICAÇÃO (MANTENDO O DESIGN SYSTEM E IMAGEM) ---
  Widget _buildSugestoesVerificacao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.error_outline, color: red, size: 24),
            SizedBox(width: 8),
            Text(
              'Sugestões de Verificação',
              style: TextStyle(
                fontFamily: 'Syne',
                color: red,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'ITs que não recebem atualização há mais de 6 meses, agrupadas por setor.',
          style: TextStyle(
            fontFamily: 'DMSans',
            color: textSecondaryColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
            color: surfaceColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: green.withOpacity(0.5),
                size: 48,
              ),
              const SizedBox(height: 12),
              const Text(
                'Tudo em dia!',
                style: TextStyle(
                  fontFamily: 'Syne',
                  color: textSecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Nenhuma IT encontrada que precise de verificação por falta de atualização.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  color: textSecondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: surfaceColor,
        border: Border(top: BorderSide(color: borderColor, width: 1)),
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

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? orange : textSecondaryColor, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontFamily: 'DMSans', color: isSelected ? orange : textSecondaryColor, fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
          if (isSelected)
            Container(margin: const EdgeInsets.only(top: 4), width: 4, height: 4, decoration: const BoxDecoration(color: orange, shape: BoxShape.circle)),
        ],
      ),
    );
  }
}