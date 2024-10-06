import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _input = '';
  String _result = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _num1 = double.tryParse(_input) ?? 0;
        _operator = value;
        _input = '';
      } else if (value == '=') {
        _num2 = double.tryParse(_input) ?? 0;
        _calculateResult();
      } else {
        _input += value;
      }
    });
  }

  void _calculateResult() {
    double res = 0;
    if (_operator == '+') {
      res = _num1 + _num2;
    } else if (_operator == '-') {
      res = _num1 - _num2;
    } else if (_operator == '*') {
      res = _num1 * _num2;
    } else if (_operator == '/') {
      if (_num2 != 0) {
        res = _num1 / _num2;
      } else {
        _result = "Error";
        return;
      }
    }
    _result = res.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _input,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              _buildButtonRow(['7', '8', '9', '/']),
              _buildButtonRow(['4', '5', '6', '*']),
              _buildButtonRow(['1', '2', '3', '-']),
              _buildButtonRow(['C', '0', '=', '+']),
              _buildButtonRow(['.']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return ElevatedButton(
          onPressed: () => _onButtonPressed(button),
          child: Text(button, style: TextStyle(fontSize: 24)),
        );
      }).toList(),
    );
  }
}
