import 'package:fitmate/database/mongo.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  await MongoDatabase.connect();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FitMate());
}