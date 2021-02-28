import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   primarySwatch: Colors.green,
        //   backgroundColor: Colors.white,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: Main()
        // home: MyHomePage(title: 'Calculator'),
        );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
            
                child: Text('Calculator',   style:TextStyle(fontSize:30, color:Colors.white,fontWeight:FontWeight.bold),),
             
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                }),
            ElevatedButton(
                child: Text('Convertor', style:TextStyle(fontSize:30, color:Colors.white,fontWeight:FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Convertor()),
                  );
                })
          ]),
    );
  }
}

class Convertor extends StatefulWidget {
  Convertor({Key key}) : super(key: key);
  @override
  _ConvertorState createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {
  double km = 0.0;
  double miles = 0.0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("1 mile is equal to 0.6213 km ",
                style: TextStyle(fontSize: 20,color: Colors.red,fontWeight:FontWeight.bold)),
            Text("Please Enter value in km ", style: TextStyle(fontSize: 25)),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
        border: OutlineInputBorder()
        
        ),
        
              style: TextStyle(fontSize: 30,color: Colors.blueAccent,fontWeight:FontWeight.bold),
              onChanged: (val) {
                setState(() {
                  km = double.parse(val);
                  miles = 0.621371 * double.parse(val);
                });
                print(miles);
                miles.toString();
                km.toString();
              },
            ),
            Text(" $km==> $miles  miles",
                style: TextStyle(fontSize: 20,color: Colors.red,fontWeight:FontWeight.bold))
          ]),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  buttonPressed(String buttonText) {
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
            // title: Text(widget.title),
            ),
        body: new Container(
            child: new Column(children: <Widget>[
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
