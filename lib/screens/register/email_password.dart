import 'dart:async';
import 'package:fitmate/screens/register/enter_details.dart';
import 'package:fitmate/screens/sign_in/email_password.dart';
import 'package:flutter/material.dart';
import 'package:fitmate/firebase/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  String _errorText = "";

  _registerUser() async {
    if (_emailController.text == "") {
      setState(() {
        _errorText = "Email field can't be empty";
      });
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _errorText = "";
        });
      });
    } else if (_passwordController.value.text == "") {
      setState(() {
        _errorText = "Password field can't be empty";
      });
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _errorText = "";
        });
      });
    } else {
      final navigator = Navigator.of(context);
      Map result = await FirebaseFunctions.create_user_and_sign_in(
          _emailController.text, _passwordController.text);
      if (result["signInCredential"] != null) {
        navigator.push(
          MaterialPageRoute(
            builder: (context) => EnterDetails(
              user: {
                "uid": result["signInCredential"].user.uid,
                "email": _emailController.text,
              },
            ),
          ),
        );
      } else {
        setState(() {
          _errorText = result["errorText"];
        });
        Timer(const Duration(seconds: 5), () {
          setState(() {
            _errorText = "";
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    highlightColor: const Color(0xff2c5246),
                    splashColor: const Color(0xff213d34),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "First time?",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "Create an account to to be part of the FitMate community and revolutionize your workouts.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter your email",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      autofillHints: const [AutofillHints.email],
                      controller: _emailController,
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 35, 34, 38),
                        filled: true,
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Set a password",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: !_passwordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 35, 34, 38),
                        filled: true,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(_passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        highlightColor: const Color(0xff2c5246),
                        splashColor: const Color(0xff213d34),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _registerUser();
                        },
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      width: double.infinity,
                      child: Text(
                        _errorText,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                          ModalRoute.withName('/'),
                        );
                      },
                      child: const Text("Log in"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
