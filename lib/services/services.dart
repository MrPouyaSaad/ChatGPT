import 'package:chat_gpt/constants/const.dart';
import 'package:chat_gpt/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: scaffoldBackgroundColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Chosen Model :',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Flexible(
                flex: 2,
                child: DropDownWidget(),
              )
            ],
          ),
        );
      },
    );
  }
}
