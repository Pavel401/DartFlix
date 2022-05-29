import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hides the onscreen keyboard
void hideKeyboard(BuildContext context) {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  FocusScope.of(context).requestFocus(FocusNode());
}