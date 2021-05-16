import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TextFieldAdaptative extends StatelessWidget {
  final isIOS = Platform.isIOS;

  final TextInputType keyboardType;
  final TextEditingController inputController;
  final String placeholder;
  final Function(String) onSubmit;

  TextFieldAdaptative({
    this.inputController,
    this.placeholder = '',
    this.onSubmit,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
                keyboardType: keyboardType,
                controller: inputController,
                onSubmitted: onSubmit,
                placeholder: placeholder,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                )),
          )
        : TextField(
            keyboardType: keyboardType,
            controller: inputController,
            onSubmitted: onSubmit,
            decoration: InputDecoration(labelText: placeholder),
          );
  }
}
