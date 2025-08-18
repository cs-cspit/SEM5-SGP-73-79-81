import 'package:flutter/material.dart';
import 'src/features/auth/login_screen.dart';
import 'src/features/learn/learn_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sediment Learner',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/learn': (context) => LearnScreen(),
      },
    );
  }
}
