import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart'; // Precisamos importar para poder voltar para o login

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Função para deslogar do Supabase
  Future<void> _fazerLogout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    
    // Volta para a tela de login apagando o histórico
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pegar o e-mail do usuário logado para dar boas-vindas
    final userEmail = Supabase.instance.client.auth.currentUser?.email ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard - My ITs Hub'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => _fazerLogout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home_work_outlined, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Bem-vindo(a)!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              userEmail,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}