import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Função que conversa com o Supabase para validar o usuário
  Future<void> _fazerLogin() async {
    setState(() => _isLoading = true);
    
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      
      // Se deu certo, mostra barrinha verde e navega para o DashboardScreen
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso!'), 
            backgroundColor: Colors.green,
          ),
        );

        // ALTERADO: agora navega para DashboardScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } on AuthException catch (e) {
      // Se a senha estiver errada ou e-mail não existir
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.message}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                'Acesso Restrito',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              
              // Campo de E-mail
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail corporativo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              
              // Campo de Senha
              TextField(
                controller: _passwordController,
                obscureText: true, // Esconde a senha
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 24),
              
              // Botão de Login
              ElevatedButton(
                onPressed: _isLoading ? null : _fazerLogin,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Entrar', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}