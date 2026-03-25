import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Importando a tela de login
import 'screens/login_screen.dart';

Future<void> main() async {
  // Garante que o Flutter está pronto antes de carregar as chaves
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Carrega as variáveis de segurança do arquivo .env
  await dotenv.load(fileName: ".env.dev");

  // 2. Conecta ao Supabase da Aions usando as chaves seguras
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ITs Hub',
      debugShowCheckedModeBanner: false, // Remove o banner "Debug"
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // Define o tema escuro como padrão
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080A0F),
      ),
      home: const LoginScreen(),
    );
  }
}