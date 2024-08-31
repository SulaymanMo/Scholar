import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/ui/signup_page.dart';
import 'package:scholar/ui/widget/btn_widget.dart';
import 'package:scholar/ui/widget/input_widget.dart';
import 'package:scholar/ui/widget/snack_bar.dart';

import '../constant.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Center(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: space),
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Icon(
                      logo,
                      size: 80,
                    ),
                    const Text(
                      'Scholar Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    const SizedBox(height: space * 6),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: space),
                    InputWidget(
                      text: 'Email',
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    const SizedBox(height: space),
                    InputWidget(
                      text: 'Password',
                      obscureText: true,
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    const SizedBox(height: space),
                    BtnWidget(
                      text: 'LOGIN',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await login();
                            if (!mounted) return;
                            Navigator.pushNamed(
                              context,
                              ChatPage.route,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showMsg(context, 'Email not found.');
                            } else if (e.code == 'wrong-password') {
                              showMsg(context, 'Wrong password.');
                            }
                          } catch (e) {
                            showMsg(context, 'Error');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignupPage.route);
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
