import 'package:fitmate/database/mongo.dart';
import 'package:flutter/material.dart';

class SelectExerciseModal extends StatefulWidget {
  const SelectExerciseModal({super.key, required this.addExercise});

  final void Function(Map workoutSection) addExercise;

  @override
  State<SelectExerciseModal> createState() => _SelectExerciseModalState();
}

class _SelectExerciseModalState extends State<SelectExerciseModal> {
  int _pageNumber = 0;
  String _targetMuscle = "";
  Map _exercise = {};

  void updatePageNumber(int update) {
    setState(() {
      _pageNumber = _pageNumber + update;
    });
  }

  void updateTargetMuscle(String update) {
    setState(() {
      _targetMuscle = update;
    });
  }

  void updateExercise(Map update) {
    setState(() {
      _exercise = update;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pageNumber == 0) {
      return SelectExerciseModalTargetPage(
        updatePageNumber: updatePageNumber,
        updateTargetMuscle: updateTargetMuscle,
      );
    } else if (_pageNumber == 1) {
      return SelectExerciseModalSearchPage(
        updatePageNumber: updatePageNumber,
        updateExercise: updateExercise,
        targetMuscle: _targetMuscle,
      );
    } else {
      return Text(_pageNumber.toString());
    }
  }
}

class SelectExerciseModalTargetPage extends StatefulWidget {
  const SelectExerciseModalTargetPage({
    super.key,
    required this.updatePageNumber,
    required this.updateTargetMuscle,
  });
  final void Function(int update) updatePageNumber;
  final void Function(String update) updateTargetMuscle;

  @override
  State<SelectExerciseModalTargetPage> createState() =>
      _SelectExerciseModalTargetPageState();
}

class _SelectExerciseModalTargetPageState
    extends State<SelectExerciseModalTargetPage> {
  final Map _targetMuscles = {
    "Core": 'waist',
    "Upper Legs": 'upper legs',
    "Back": 'back',
    "Lower Legs": 'lower legs',
    "Chest": 'chest',
    "Biceps/Triceps": 'upper arms',
    "Cardio": 'cardio',
    "Shoulders": 'shoulders',
    "Lower Arms": 'lower arms',
    "Neck": 'neck'
  };

  String _selectedTargetMuscle = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
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
        const Text(
          "Which muscle group does this exercise target?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 10,
            children: [
              for (String target in _targetMuscles.keys.toList())
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTargetMuscle = target;
                    });
                  },
                  child: TargetBox(
                      target: target,
                      selected: (_selectedTargetMuscle == target)),
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            widget.updateTargetMuscle(_targetMuscles[_selectedTargetMuscle]);
            widget.updatePageNumber(1);
          },
          icon: Icon(
            Icons.arrow_forward_rounded,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
        )
      ],
    );
  }
}

class SelectExerciseModalSearchPage extends StatefulWidget {
  const SelectExerciseModalSearchPage({
    super.key,
    required this.updatePageNumber,
    required this.updateExercise,
    required this.targetMuscle,
  });

  final void Function(int update) updatePageNumber;
  final void Function(Map update) updateExercise;
  final String targetMuscle;

  @override
  State<SelectExerciseModalSearchPage> createState() =>
      _SelectExerciseModalSearchPageState();
}

class _SelectExerciseModalSearchPageState
    extends State<SelectExerciseModalSearchPage> {
  List _exerciseList = [];
  List _filteredExerciseList = [];
  bool _showLoader = true;

  _getExerciseList(String targetMuscle) async {
    List exerciseList = await MongoDatabase.listExercise(targetMuscle);
    setState(() {
      _exerciseList = exerciseList;
      _filteredExerciseList = exerciseList;
      _showLoader = false;
    });
  }

  void _searchExercise(String query) {
    final filteredExerciseList = _exerciseList.where((exercise) {
      final exerciseName = exercise["name"].toLowerCase();
      final input = query.toLowerCase();
      return exerciseName.contains(input);
    }).toList();

    setState(() {
      _filteredExerciseList = filteredExerciseList;
    });
  }

  @override
  void initState() {
    _getExerciseList(widget.targetMuscle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _showLoader
        ? Expanded(child: Text("Loading"))
        : Container(
            child: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  highlightColor: const Color(0xff2c5246),
                  splashColor: const Color(0xff213d34),
                  onPressed: () {
                    widget.updatePageNumber(-1);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                TextField(
                  onChanged: _searchExercise,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredExerciseList.length,
                    itemBuilder: (context, index) {
                      return Text(_filteredExerciseList[index]["name"]);
                    },
                  ),
                )
              ],
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : null,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        target,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
