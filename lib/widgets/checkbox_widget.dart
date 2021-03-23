import 'package:flutter/material.dart';
import 'package:my_todo_s/services/database.dart';

class CheckboxWidget extends StatefulWidget {

  final bool checkedValue;
  final String text;
  final String id;

  CheckboxWidget({@required this.checkedValue, @required this.text, @required this.id});

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {

  bool checkedValue;
  var primaryColor = const Color(0xFF008080);
  var segundaryColor = Colors.white;
  var terciaryColor = const Color(0xFF20B2AA);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: primaryColor,
      title: Text(widget.text, style: TextStyle(color: Colors.black)),
      value: widget.checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
          updateTask();
        });
      },
      controlAffinity: ListTileControlAffinity.leading, 
    );
  }

  updateTask() async {
    bool result = await DatabaseMethods().updateTask(widget.id, !widget.checkedValue);
    if(result)
      print("Sucesssooooooo");
      // showInSnackBar("Task Added!");
    else
      print("Errrooooooo");
      // showInSnackBar("Error!");
  }
}