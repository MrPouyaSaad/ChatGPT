import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/providers/models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelsProvider>(context, listen: true);
    currentModel = modelProvider.getCurrentlyModel;
    return FutureBuilder<List<Models>>(
      future: modelProvider.getAllModels(),
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
              elevation: 0,
              isDense: true,
              iconEnabledColor: Colors.white,
              borderRadius: BorderRadius.circular(9),
              padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
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
                // setState(() {
                //   currentModel = value.toString();
                // });
                modelProvider.setCurrentlyModel(value.toString());
              },
            ),
          );
        }
      },
    );
  }
}
