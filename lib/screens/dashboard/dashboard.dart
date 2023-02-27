import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmate/screens/workouts/create_workout.dart';
import 'package:flutter/material.dart';
import 'package:fitmate/database/mongo.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    required this.userID,
  });

  final String userID;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map _user = {};
  List _workouts = [];

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  _getUserInfo() async {
    Map userData = await MongoDatabase.getUserInfo(widget.userID);
    if (userData["_id"] != null) {
      setState(() {
        _user = userData;
      });
    }
  }

  _getUserWorkouts() async {
    List userData = await MongoDatabase.getUserWorkouts(widget.userID);
    setState(() {
      _workouts = userData;
    });
  }

  @override
  void initState() {
    _getUserInfo();
    _getUserWorkouts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_user["_id"] == null)
          ? const Text("Loading")
          : SafeArea(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good ${greeting()}, ${_user["name"]}.",
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "Ready for a workout?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Workouts",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          if (_workouts.isEmpty) ...[
                            const Text("No saved workouts")
                          ] else ...[
                            for (Map workout in _workouts)
                              Text("${workout["title"]}")
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateWorkout(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
