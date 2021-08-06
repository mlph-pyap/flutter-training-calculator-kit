import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

//changenotifier class for increment
class HomeChangeNotifier extends ChangeNotifier {
  String stringInput = "0";
  String finalInput = "";

  Future<void> textFieldAction(String action) async {
    //If our `inputOperation is empty first input will be place the value and first value is not zero
    bool valid = true;
    if (stringInput == "0") {
      stringInput = "";
    }
    if (action == '/' ||
        action == 'x' ||
        action == '-' ||
        action == '+' ||
        action == '=') {
      valid = stringInput != "";
    }

    if (valid) {
      stringInput = stringInput + action;
    } else {
      stringInput = "0";
    }

    notifyListeners();
  }

  Future<void> deleteAction() async {
    //If our `inputOperation is empty first input will be place the value and first value is not zero
    stringInput = stringInput.substring(0, stringInput.length - 1);
    if (stringInput == "") {
      stringInput = "0";
    }
    notifyListeners();
  }

  Future<void> operationAction(String action) async {
    Parser p = Parser();
    stringInput = stringInput.replaceAll('x', '*');
    Expression exp = p.parse(stringInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    finalInput = eval.toString();

    notifyListeners();
  }

  Future<void> clearAll() async {
    stringInput = "0";
    finalInput = "";

    notifyListeners();
  }
}
