import 'package:flutter/material.dart';
import 'package:scholar/ui/widget/btn_widget.dart';
import 'package:scholar/ui/widget/input_widget.dart';
import 'package:scholar/ui/widget/snack_bar.dart';
import '../constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  static const String route = 'signup_page';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;
  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
          child: Form(
            key: formKey,
            child: Center(
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
                      'Register',
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
                      text: 'Sign Up',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await registerUser();
                            if (!mounted) return;
                            Navigator.pushNamed(
                              context,
                              ChatPage.route,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showMsg(context,
                                  'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              showMsg(context,
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            showMsg(context, 'Error');
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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
