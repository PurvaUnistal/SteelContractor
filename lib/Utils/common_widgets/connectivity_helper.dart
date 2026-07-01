import 'dart:io';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/internet_connectivity_pop_widget.dart';

class ConnectivityHelper {

  static Future<dynamic> allConnectivityCheck({
    required BuildContext context,
    VoidCallback? onRetry,
  }) async {
    bool isConnected = await checkInterNetConnect();
    if (isConnected == false) {
      if (!context.mounted) return false;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InternetConnectivityPopWidget(onRetry: onRetry),
        ),
      );
      return false;
    }
    return true;
  }

  static Future<bool> checkInterNetConnect() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}