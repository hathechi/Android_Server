import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void snackBar({required var message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
