import 'package:fitmate/components/select_exercise_modal.dart';
import 'package:flutter/material.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  List _currentWorkout = [];

  final List _targetMuscles = [
    "lats",
    "pectorals",
    "abs",
    "glutes",
  ];

  void updateCurrentWorkout(Map workoutSection) {
    setState(() {
      _currentWorkout = [..._currentWorkout, workoutSection];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Create your own customized workout"),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setStateModal) => Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            child: SelectExerciseModal(
                              addExercise: updateCurrentWorkout,
                            )),
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
