import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import './previousCal.dart';
import './history.dart';

Future<void> calValue(String val) async {
  CollectionReference myVal =
      FirebaseFirestore.instance.collection("calculator");
  myVal.add({'calculatedValue': val});
}

class Calculator extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Calculator> {
  String output = "0";
  String equation = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  addStringToSF(value) async {
    var now = DateTime.now();
    var date = DateFormat.yMMMd().format(now);
    var time = DateFormat('hh:mm').format(DateTime.now());
    print("$date $time");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('equation', value);
    prefs.setString('timestamp', "$date $time");
  }

  buttonPressed(String buttonText) async {
    print(buttonText);
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      await addStringToSF("$num1 $operand $num2 =$_output");
      calValue("$num1 $operand $num2 =$_output");
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }
    print(_output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
        child: new OutlineButton(
      padding: new EdgeInsets.all(24.0),
      child: new Text(buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      onPressed: () => {buttonPressed(buttonText)},
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0, top: 20.0),
                child: GestureDetector(
                    onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              },
                  child: Text("History",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                )),
          ],
        ),
        body: new Container(
            child: new Column(children: <Widget>[
          ElevatedButton(
              child: Text('Previous Calculation',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Previous()),
                );
              }
              ),
          new Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: new Text(output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold)),
          ),
          new Expanded(
            child: new Divider(),
          ),
          new Column(children: [
            new Row(children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/"),
            ]),
            new Row(children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("X"),
            ]),
            new Row(children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ]),
            new Row(children: [
              buildButton(","),
              buildButton("0"),
              buildButton("00"),
              buildButton("+"),
            ]),
            new Row(children: [
              buildButton("CLEAR"),
              buildButton("="),
            ]),
          ])
        ])));
  }
}
