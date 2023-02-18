import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../widgets/toggle_chip.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => GeneratorPageState();
}

enum Position { none, red1, red2, red3, blue1, blue2, blue3 }

class GeneratorPageState extends State<GeneratorPage> {
  final _commentController = TextEditingController();
  final _teamController = TextEditingController();

  Future _getData() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _commentController.text = preferences.getString('Comments') ?? '';
      _teamController.text = preferences.getString('Team number') ?? '';
    });
  }

  Future _saveData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('Comments', _commentController.text);
    preferences.setString('Team number', _teamController.text);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //allows the home page widget to use variables from the app state
    var appState = context.watch<MyAppState>();

    void updatePosition(Position value) {
      setState(() {
        appState.position = value;
      });
    }

    return Center(
        child: Column(
            //centres the column in the GeneratorPage widget
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Padding(
            //gives the text more space
            padding: EdgeInsets.all(8.0),
            child: Text('Comments:'),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _commentController,
                ),
              )), //allows the user to type input
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Team number:'),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _teamController,
                ),
              )),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Robot position:'),
          ),
          //creates buttons to select the robot's position

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleChip(
                  text: "Red 1",
                  onPressed: updatePosition,
                  value: Position.red1,
                  selection: appState.position,
                  icon1: Icons.circle,
                  icon2: Icons.circle_outlined),
              ToggleChip(
                  text: "Red 2",
                  onPressed: updatePosition,
                  value: Position.red2,
                  selection: appState.position,
                  icon1: Icons.circle,
                  icon2: Icons.circle_outlined),
              ToggleChip(
                  text: "Red 3",
                  onPressed: updatePosition,
                  value: Position.red3,
                  selection: appState.position,
                  icon1: Icons.circle,
                  icon2: Icons.circle_outlined),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleChip(
                  text: "Blue 1",
                  onPressed: updatePosition,
                  value: Position.blue1,
                  selection: appState.position,
                  icon1: Icons.circle,
                  icon2: Icons.circle_outlined),
              ToggleChip(
                  text: "Blue 2",
                  onPressed: updatePosition,
                  value: Position.blue2,
                  selection: appState.position,
                  icon1: Icons.circle,
                  icon2: Icons.circle_outlined),
              ToggleChip(
                  text: "Blue 3",
                  onPressed: updatePosition,
                  value: Position.blue3,
                  selection: appState.position,
                  icon1: Icons.circle,
                  icon2: Icons.circle_outlined),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                    "Save")), //adds a button to save the data, currently not functional
          )
        ]));
  }
}
