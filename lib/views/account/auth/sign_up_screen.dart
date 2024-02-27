import 'package:app/component/input_outline_button.dart';
import 'package:app/component/input_text_button.dart';
import 'package:app/component/input_text_field.dart';
import 'package:app/controllers/Controllers.dart';
import 'package:app/extension/string_extension.dart';
import 'package:app/views/account/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign up to start",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                InputTextField(
                    title: "Full Name",
                    textEditingController: fullNameController,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "this field in not empty";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                    title: "email",
                    textEditingController: emailController,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "this field in not empty";
                      } else if (!val.isValidEmail) {
                        return "please enter valid email";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                    title: "Password",
                    obsecureText: true,
                    textEditingController: passwordController,
                    validation: (String? val) {
                      List<String> _validation = [];
                      if (val == null || val.isEmpty) {
                        return "this field in not empty";
                      } else {
                        if (!val.isValidPasswordHasNumber) {
                          _validation.add("must contain 1 number");
                        }
                        if (!val.isValidPasswordHasCapitalLetter) {
                          _validation.add("must contain 1 capital letter");
                        }
                        if (!val.isValidPasswordHasLowerCaseLetter) {
                          _validation.add("must contain 1 lower case letter");
                        }
                        if (!val.isValidPasswordHasSpecialCharacter) {
                          _validation.add(
                              "must contain 1 special character (! @ \$ # %)");
                        }
                        String msg = "";
                        if (_validation.isNotEmpty) {
                          for (int i = 0; i < _validation.length; i++) {
                            msg = msg + _validation[i];
                            if ((i + 1) != _validation.length) {
                              msg = msg + "\n";
                            }
                          }
                        }
                        return msg.isNotEmpty ? msg : null;
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                    title: "Confirm Password",
                    obsecureText: true,
                    textEditingController: confirmController,
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "this field in not empty";
                      } else if (passwordController.text != val) {
                        return "Confirm password not match";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                const Spacer(),
                InputTextButton(
                    title: "Sign Up",
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        authController.login(
                          fullName: fullNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                InputOutlineButton(
                    title: "Back",
                    onClick: () {
                      Navigator.of(context).pop();
                    }),
                const Spacer(
                  flex: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("i have an account"),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
