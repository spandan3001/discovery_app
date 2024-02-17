import 'package:discovery_app/utils/snackbar_helper.dart';
import 'package:discovery_app/views/discovery_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const DiscoveryPage(),
      scaffoldMessengerKey: SnackBarHelper.key,
    );
  }
}
