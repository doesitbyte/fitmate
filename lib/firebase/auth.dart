import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  static create_user(emailAddress, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static sign_in(emailAddress, password) async {
    Map result = {
      "signInCredential": null,
      "errorText": "",
    };
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      result["signInCredential"] = credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result["errorText"] = "User not registered.";
      } else if (e.code == 'wrong-password') {
        result["errorText"] = "Incorrect password";
      }
    }

    return result;
  }

  static create_user_and_sign_in(emailAddress, password) async {
    Map result = {
      "createCredentail": null,
      "signInCredential": null,
      "errorText": ""
    };

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      result["createCredentail"] = credential;
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        result["signInCredential"] = credential;
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result["errorText"] = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        result["errorText"] = "This email is already in use. Please log in.";
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
