import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {

  final bool checkedValue;
  final String text;

  CheckboxWidget({@required this.checkedValue, @required this.text});

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
        });
      },
      controlAffinity: ListTileControlAffinity.leading, 
    );
  }
}