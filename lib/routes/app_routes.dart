import 'package:get/get.dart';
import 'package:study_app/screens/introduction/introduction.dart';
import 'package:study_app/screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/introduction',
          page: () => const AppIntroductionScreen(),
        ),
      ];
}
