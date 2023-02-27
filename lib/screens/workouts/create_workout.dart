import 'package:flutter/material.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  String _selectedTargetMuscle = "";

  final List _targetMuscles = [
    "lats",
    "pectorals",
    "abs",
    "glutes",
  ];

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
                          child: Column(
                            children: [
                              Text(
                                "Which muscle group does this exercise target?",
                                style: TextStyle(),
                              ),
                              Container(
                                child: Wrap(
                                  children: [
                                    for (String target in _targetMuscles)
                                      InkWell(
                                        onTap: () {
                                          setStateModal(() {
                                            _selectedTargetMuscle = target;
                                          });
                                        },
                                        child: TargetBox(
                                            target: target,
                                            selected: (_selectedTargetMuscle ==
                                                target)),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
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

class TargetBox extends StatelessWidget {
  const TargetBox({
    super.key,
    required this.target,
    required this.selected,
  });

  final String target;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : null,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(target),
    );
  }
}
