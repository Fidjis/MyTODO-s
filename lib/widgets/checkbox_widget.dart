import 'package:flutter/material.dart';
import 'package:my_todo_s/helper/consts.dart';
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

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Consts.primaryColor,
      title: widget.checkedValue ? 
        Text(widget.text, style: TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough)) : //texto com Tracado
        Text(widget.text, style: TextStyle(color: Colors.black, )), //texto sem tracado
      value: widget.checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
          updateTask();
        });
      },
      secondary: IconButton(icon: Icon(Icons.delete), color: Consts.primaryColor,onPressed: (){
        deleteTask();
      }),
      controlAffinity: ListTileControlAffinity.leading, 
    );
  }

  updateTask() async {
    bool result = await DatabaseMethods().updateTask(widget.id, !widget.checkedValue);
    if(result)
      print("Sucesso");
      // showInSnackBar("Task Added!");
    else
      print("Errro");
      // showInSnackBar("Error!");
  }

  deleteTask() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attention!"),
          content: Text("Are you sure you want to delete?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed:  () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Continue"),
              onPressed:  () async {
                bool result = await DatabaseMethods().deleteTask(widget.id);
                if(result)
                  print("Sucesso");
                  // showInSnackBar("Task Added!");
                else
                  print("Errro");
                  // showInSnackBar("Error!");

                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}