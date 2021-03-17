import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Previous extends StatefulWidget {
  Previous({Key key}) : super(key: key);
  @override
  _PrevCalculation createState() => _PrevCalculation();
}

class _PrevCalculation extends State<Previous> {
  String equation = "";
  String timeStamp = "";
  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      equation = prefs.getString('equation');
      timeStamp = prefs.getString('timestamp');
    });
  }

  @override
  void initState() {
    super.initState();
    getStringValuesSF();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Previous calculation"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("equation : $equation", style: TextStyle(fontSize: 25)),
                  Text("timeStamp : $timeStamp",
                      style: TextStyle(fontSize: 25)),
                ])));
  }
}
