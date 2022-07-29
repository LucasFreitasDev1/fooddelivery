import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'shared/dependencies_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  initGetIt();
  try {
    runApp(const AppWidget());
  } on Exception catch (e) {
    log(e.toString());
    runApp(const Scaffold(
      body: LinearProgressIndicator(),
    ));
  }
}
