import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'home_view_model.dart';

T useChangeNotifierListenable<T extends ChangeNotifier>(T data) {
  final state = useState<T>(data);
  return useListenable(state.value);
}

class HomeView extends HookWidget {
  final textController = TextEditingController();

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+'
  ];

  @override
  Widget build(BuildContext context) {
    //This class must inside the build function
    final homeChangeNotifier =
        useChangeNotifierListenable(HomeChangeNotifier());

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.grey,
            alignment: Alignment.centerRight,
            child: Text(
              //We need to convert to string as the variable was double
              '${homeChangeNotifier.stringInput.toString()} ',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.grey,
            alignment: Alignment.centerRight,
            child: Text(
              //We need to convert to string as the variable was double
              '${homeChangeNotifier.finalInput.toString()} ',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.grey,
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext buildContext, int index) {
                      return button(() {
                        if (buttons[index] == "=") {
                          homeChangeNotifier.operationAction(buttons[index]);
                        } else if (buttons[index] == "DEL") {
                          homeChangeNotifier.deleteAction();
                        } else if (buttons[index] == "C") {
                          homeChangeNotifier.clearAll();
                        } else {
                          homeChangeNotifier.textFieldAction(buttons[index]);
                        }
                      },
                          buttons[index],
                          isOperator(buttons[index])
                              ? Colors.blueAccent
                              : Colors.white);
                    }),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  Widget button(final buttonTapped, String buttonString, Color buttonColor) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: EdgeInsets.all(0.2),
        child: ClipRect(
          child: Container(
            padding: EdgeInsets.all(1),
            color: buttonColor,
            child: Text(
              buttonString,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
