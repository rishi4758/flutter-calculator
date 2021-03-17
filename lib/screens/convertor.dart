import 'package:flutter/material.dart';
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
        appBar: AppBar(
            // title: Text(widget.title),
            ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("1 mile is equal to 0.6213 km ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                Text("Please Enter value in km ",
                    style: TextStyle(fontSize: 25)),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                  onChanged: (val) {
                    setState(() {
                      km = double.parse(val);
                      miles = 0.621371 * double.parse(val);
                    });
                    miles.toString();
                    km.toString();
                  },
                ),
                Text(" $km==> $miles  miles",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold))
              ]),
        ));
  }
}
