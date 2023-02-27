import 'dart:async';

import 'package:fitmate/app.dart';
import 'package:fitmate/database/mongo.dart';
import 'package:fitmate/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class EnterDetails extends StatefulWidget {
  const EnterDetails({super.key, required this.user});

  final Map user;

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final _nameController = TextEditingController();
  final _yearsController = TextEditingController();

  String _errorText = "";

  saveUserInfo() async {
    final navigator = Navigator.of(context);
    if (_nameController.value.text != "" && _yearsController.value.text != "") {
      var result = await MongoDatabase.saveUserInfo(
        widget.user["email"],
        _nameController.text,
        _yearsController.text,
        widget.user["uid"],
      );
      if (!result.isFailure) {
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => FitMate(),
          ),
          ((route) => false),
        );
      }
    } else {
      if (_nameController.value.text == "") {
        setState(() {
          _errorText = "Name cannot be empty";
        });
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _errorText = "";
          });
        });
      } else if (_yearsController.value.text == "") {
        setState(() {
          _errorText = "Years cannot be empty";
        });
        Timer(const Duration(seconds: 3), () {
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
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "You're in!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Congrats on becoming a valuable member of the FitMate community!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What should we call you?",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 35, 34, 38),
                        filled: true,
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 2,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "How long have you been training?",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _yearsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 35, 34, 38),
                        filled: true,
                        hintText: "Years",
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
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      highlightColor: const Color(0xff2c5246),
                      splashColor: const Color(0xff213d34),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        saveUserInfo();
                      },
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
