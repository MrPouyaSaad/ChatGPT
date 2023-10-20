import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String currentModel = 'text-search-babbage-doc-001';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Models>>(
      future: ApiServices.getModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty)
          return SizedBox.shrink(
            child: Text('Empty'),
          );
        else {
          return FittedBox(
            child: DropdownButton(
              value: currentModel,
              dropdownColor: scaffoldBackgroundColor,
              items: List<DropdownMenuItem<String>>.generate(
                snapshot.data!.length,
                (index) {
                  final data = snapshot.data![index];
                  return DropdownMenuItem(
                    value: data.id,
                    child: Text(
                      data.id,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                },
              ),
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });
              },
            ),
          );
        }
      },
    );
  }
}
