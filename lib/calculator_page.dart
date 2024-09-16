import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _inputSequence = "";
  String _operand = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      try {
        if (buttonText == "C") {
          _output = "0";
          _inputSequence = "";
          _num1 = 0;
          _num2 = 0;
          _operand = "";
        } else if (buttonText == "x²") {
          _num1 = double.parse(_output);
          _output = (_num1 * _num1).toString();
          _inputSequence = "$_num1² = $_output";
          _num1 = 0;
        }
        else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
          _num1 = double.parse(_output);
          _operand = buttonText;
          _output = "0";
          _inputSequence += " $buttonText ";
        } else if (buttonText == ".") {
          if (!_output.contains(".")) {
            _output += buttonText;
            _inputSequence += buttonText;
          }
        } else if (buttonText == "=") {
          _num2 = double.parse(_output);
          if (_operand == "+") {
            _output = (_num1 + _num2).toString();
          } else if (_operand == "-") {
            _output = (_num1 - _num2).toString();
          } else if (_operand == "*") {
            _output = (_num1 * _num2).toString();
          } else if (_operand == "/") {
            if (_num2 == 0) {
              throw Exception("Division by zero");
            }
            _output = (_num1 / _num2).toString();
          }
          _inputSequence += " $buttonText $_output";
          _num1 = 0;
          _num2 = 0;
          _operand = "";
        } else {
          if (_output == "0") {
            _output = buttonText;
          } else {
            _output += buttonText;
          }
          _inputSequence += buttonText;
        }
      } catch (e) {
        _output = "Error";
        _inputSequence = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 24.0),
          ),
      )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jad's Very Cool Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _inputSequence,
                    style: const TextStyle(fontSize: 24.0, color: Colors.grey),
                  ),
                  Text(
                    _output,
                    style: const TextStyle(fontSize: 48.0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("0"),
                    _buildButton("."),
                    _buildButton("="),
                    _buildButton("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("C"),
                    _buildButton("x²"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}