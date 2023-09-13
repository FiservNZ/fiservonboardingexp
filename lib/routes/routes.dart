import 'package:fiservonboardingexp/screens/faq_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/screens/manager/manager_view.dart';
import 'package:fiservonboardingexp/screens/profile_page.dart';
import 'package:fiservonboardingexp/screens/settings_page.dart';
import 'package:fiservonboardingexp/util/mc_testing/category%20screens/cc_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/category%20screens/compliance_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/category%20screens/hs_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/category%20screens/orientation_screen.dart';
import 'package:fiservonboardingexp/widgets/check_user.dart';
import 'package:get/get.dart';

import '../screens/help_page.dart';
import '../screens/teaser pages/teaser.dart';

class FiservAppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const CheckUser(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/teaser",
          page: () => const TeaserScreen(),
        ),
        GetPage(
          name: "/help",
          page: () => const HelpPage(),
        ),
        GetPage(
          name: "/home",
          page: () => HomePage(),
        ),
        GetPage(
          name: "/manager",
          page: () => ManagerView(),
        ),
        GetPage(
          name: "/mainScreen",
          page: () => const MainScreen(),
        ),
        GetPage(
          name: "/faq",
          page: () => FaqPage(),
        ),
        GetPage(
          name: "/settings",
          page: () => SettingsPage(),
        ),
        GetPage(
          name: "/profile",
          page: () => const ProfilePage(),
        ),
        GetPage(
          name: OrientationScreen.routeName,
          page: () => const OrientationScreen(),
        ),
        GetPage(
          name: CustomsCultureScreen.routeName,
          page: () => const CustomsCultureScreen(),
        ),
        GetPage(
          name: HealthSafetyScreen.routeName,
          page: () => const HealthSafetyScreen(),
        ),

        GetPage(
          name: ComplianceScreen.routeName,
          page: () => const ComplianceScreen(),
        ),

        // GetPage(
        //     name: QuizQuestionScreen.routeName,
        //     page: () => const QuizQuestionScreen(),
        //     binding: BindingsBuilder(() {
        //       Get.put(QuestionController());
        //     })),
      ];
}
