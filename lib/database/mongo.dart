import 'package:mongo_dart/mongo_dart.dart';
import "package:fitmate/constants.dart";

class MongoDatabase {
  static var db;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
  }

  static listExercise(String bodyPart) async {
    var collection = db.collection("exercise");
    try {
      final exercises = await collection.find({
        "bodyPart": bodyPart,
      }).toList();
      return exercises;
    } catch (e) {
      return Future.value(e);
    }
  }

  static saveUserInfo(
    String email,
    String name,
    String experience,
    String firebaseID,
  ) async {
    var collection = db.collection("users");
    try {
      var result = await collection.insertOne({
        "_id": firebaseID,
        "email": email,
        'name': name,
        'experience': experience,
      });
      return result;
    } catch (e) {
      return Future.value(e);
    }
  }

  static getUserInfo(String firebaseID) async {
    var collection = db.collection("users");
    try {
      var result = await collection.findOne({
        "_id": firebaseID,
      });
      return result;
    } catch (e) {
      return Future.value(e);
    }
  }

  static getUserWorkouts(String firebaseID) async {
    var collection = db.collection("workouts");
    try {
      var result = await collection.find({
        "_id": firebaseID,
      }).toList();
      return result;
    } catch (e) {
      return Future.value(e);
    }
  }
}
