import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calcutronic',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new MyHomePage(title: 'Calcutronic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = '0';
  String _output = '0';
  String _operand = "";
  double _num1 = 0.0;
  double _num2 = 0.0;

  buttonPressed(String buttonText) {
    if (buttonText == 'CLEAR') {
      _output = '0';
      _operand = '';
      _num1 = 0.0;
      _num2 = 0.0;
    } else if (int.tryParse(buttonText) is int) {
      // Número
      _output = (int.parse(_output + buttonText)).toString();
    } else {
      // Operador
      if (buttonText == '.') {
        if (!_output.contains('.')) {
          _output += buttonText;
        }

        return;
      } else if (buttonText == '=') {
        _num2 = double.parse(_output);

        switch (_operand) {
          case '+':
            _output = (_num1 + _num2).toStringAsFixed(2);
            break;
          case '-':
            _output = (_num1 - _num2).toStringAsFixed(2);
            break;
          case '/':
            _output = (_num1 / _num2).toStringAsFixed(2);
            break;
          case '*':
            _output = (_num1 * _num2).toStringAsFixed(2);
            break;
        }
      } else {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _output = '0';
      }
    }
    print('_output: $_output');
    setState(() {
      output = _output;
    });
    print(output);
  }

  Widget buildButtonCalculator(String buttonText) {
    return Expanded(
      child: MaterialButton(
        padding: EdgeInsets.all(20.0),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
        color: Colors.blueGrey,
        textColor: Colors.tealAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 54.0, horizontal: 12.0),
              child: Text(
                output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButtonCalculator('7'),
                  buildButtonCalculator('8'),
                  buildButtonCalculator('9'),
                  buildButtonCalculator('/'),
                ],
              ),
              Row(
                children: [
                  buildButtonCalculator('4'),
                  buildButtonCalculator('5'),
                  buildButtonCalculator('6'),
                  buildButtonCalculator('*'),
                ],
              ),
              Row(
                children: [
                  buildButtonCalculator('1'),
                  buildButtonCalculator('2'),
                  buildButtonCalculator('3'),
                  buildButtonCalculator('-'),
                ],
              ),
              Row(
                children: [
                  buildButtonCalculator('.'),
                  buildButtonCalculator('0'),
                  buildButtonCalculator('00'),
                  buildButtonCalculator('+'),
                ],
              ),
              Row(
                children: [
                  buildButtonCalculator('CLEAR'),
                  buildButtonCalculator('=')
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
