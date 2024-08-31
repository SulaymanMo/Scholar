import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar/ui/chat_page.dart';
import 'package:scholar/ui/login_page.dart';
import 'package:scholar/ui/signup_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scholar',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo[200],
      ),
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (ctx) => const LoginPage(),
        SignupPage.route: (ctx) => const SignupPage(),
        ChatPage.route: (ctx) => const ChatPage(),
      },
    );
  }
}
