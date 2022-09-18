import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/binding/initial_binding.dart';
import 'package:study_app/configs/themes/app_light_theme.dart';
import 'package:study_app/controllers/theme_controller.dart';
import 'package:study_app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBinding().dependencies();
  runApp(const MyApp());
}
// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

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
