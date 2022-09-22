import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/binding/initial_binding.dart';
import 'package:study_app/controllers/theme_controller.dart';
import 'package:study_app/firebase_options.dart';
import 'package:study_app/routes/app_routes.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  InitialBinding().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().getLightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}
