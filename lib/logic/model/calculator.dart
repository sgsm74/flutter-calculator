import 'package:expressions/expressions.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CalculatorModel extends ChangeNotifier {
  List<String> _pharases = [];
  String _result = '';
  List<String> get pharases => _pharases;
  String get result => _result;

  CalculatorModel();

  void add(String key) {
    _pharases.add(key.toString());
    //calculateResult();
    RegExp re = RegExp(r'[0-9][\+\*\-\/\%][0-9]+$');
    if (re.hasMatch(toString())) calculateResult();
    notifyListeners();
  }

  void clear() {
    _pharases.clear();
    _result = '';
    notifyListeners();
  }

  void backspace() {
    List<String> opernads = [
      "÷",
      "×",
      "-",
      "+",
    ];
    if (_pharases.isNotEmpty) {
      _pharases.removeLast();
      if (_pharases.isNotEmpty && !opernads.contains(_pharases.last)) {
        calculateResult();
      }
      if (_pharases.isEmpty) {
        clear();
      }
    }
    notifyListeners();
  }

  String toString() {
    String phrases = '';
    for (int i = 0; i < _pharases.length; i++) {
      if (_pharases[i] == "×") {
        phrases = phrases + "*";
      } else if (_pharases[i] == "÷") {
        phrases = phrases + "/";
      } else
        phrases = phrases + _pharases[i];
    }
    return phrases;
  }

  calculateResult() {
    Expression expression = Expression.parse(toString());
    final evaluator = const ExpressionEvaluator();
    Map<String, String> context = {"÷": "/", "×": "*"};
    var result = evaluator.eval(expression, context);
    /* if (result > 999999999) {
      return result.toStringAsExponential(3);
    }
    NumberFormat numberFormat = NumberFormat.decimalPattern('en');
    _result = numberFormat.format(result).toString(); */
    _result = result.toString();
    notifyListeners();
  }

  hitAssignKey() {
    pharases.clear();
    pharases.add(result);
    _result = '';
    notifyListeners();
  }
}
