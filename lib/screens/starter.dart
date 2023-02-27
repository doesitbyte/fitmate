import 'package:fitmate/screens/register/email_password.dart';
import 'package:fitmate/screens/sign_in/email_password.dart';
import 'package:flutter/material.dart';

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(
                      width: 200,
                      image: AssetImage("assets/images/FitMateLogo.png"),
                    ),
                    Text(
                      "Train To Unleash Your Inner Athlete".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    const Text(
                      "FitMate is your workout partner that provides customized workout plans and tracking tools to help you achieve your fitness goals.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(59, 58, 66, 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Register",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromRGBO(15, 15, 15, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 10, 20),
                              child: const Text(
                                "Sign In",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
