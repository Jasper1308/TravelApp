import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/app_root.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text('header')
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: action == AuthAction.signIn
                    ? const Text('Bem-vindo ao seu app de viagem! Faça login para continuar.')
                    : const Text('Crie sua conta para começar a planejar suas aventuras!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Ao fazer login, você concorda com nossos termos e condições.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }

        // Se o usuário estiver logado, mostre a tela principal do seu aplicativo
        return const AppRoot();
      },
    );
  }
}
