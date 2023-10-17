import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String currentModel = '1';
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: currentModel,
      items: [
        DropdownMenuItem(
          value: '1',
          child: Text('1'),
        ),
        DropdownMenuItem(
          value: '2',
          child: Text('2'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }
}
