import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmate/screens/dashboard/dashboard.dart';
import 'package:fitmate/screens/starter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FitMate extends StatefulWidget {
  const FitMate({super.key});

  @override
  State<FitMate> createState() => _FitMateState();
}

class _FitMateState extends State<FitMate> {
  bool _userSignedIn = false;
  String _userID = "";

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _userSignedIn = true;
          _userID = user.uid;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => _userSignedIn
              ? Dashboard(
                  userID: _userID,
                )
              : const Starter()
        },
        debugShowCheckedModeBanner: false,
        title: "FitMate",
        theme: ThemeData(
          fontFamily: 'Oswald',
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: 'Work'),
          primaryColor: const Color(0xFF6ECCAF),
          cardColor: const Color(0xFF212121),
          primarySwatch: const MaterialColor(
            0xFF6ECCAF,
            <int, Color>{
              50: Color(0xff63b89e), //10%
              100: Color(0xff58a38c), //20%
              200: Color(0xff4d8f7a), //30%
              300: Color(0xff427a69), //40%
              400: Color(0xff376658), //50%
              500: Color(0xff2c5246), //60%
              600: Color(0xff213d34), //70%
              700: Color(0xff162923), //80%
              800: Color(0xff0b1411), //90%
              900: Color(0xff000000), //100%
            },
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(15, 15, 15, 1),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000000),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xFF000000),
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        // home: _userSignedIn ? const Dashboard() : const Starter(),
      ),
    );
  }
}
