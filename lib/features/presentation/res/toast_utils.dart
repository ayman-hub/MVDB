import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';


enum MessageErrorType { success, error }

void showToast(String msg,
    {MessageErrorType errorType = MessageErrorType.error}) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor:
    msg.contains('success')?Colors.green:(errorType == MessageErrorType.error ? Colors.red : Colors.green),
    icon: Icon(
      errorType == MessageErrorType.error ? Icons.error : Icons.check_circle,
      color: Colors.white,
    ),
    messageText: Text(
      msg,
      style: const TextStyle(fontSize: 15, color: Colors.white),
    ),
    isDismissible: true,
    duration: const Duration(seconds: 3),
  ));
}
