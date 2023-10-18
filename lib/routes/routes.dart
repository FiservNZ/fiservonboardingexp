import 'package:fiservonboardingexp/screens/menu%20drawer/faq_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/screens/manager/manager_view.dart';
import 'package:fiservonboardingexp/screens/profile_page.dart';
import 'package:fiservonboardingexp/screens/menu%20drawer/settings%20components/settings_page.dart';
import 'package:fiservonboardingexp/controllers/check_user.dart';
import 'package:fiservonboardingexp/screens/module/task%20pages/quiz%20screens/question_screen.dart';
import 'package:get/get.dart';
import '../controllers/quiz controllers/question_controller.dart';
import '../screens/menu drawer/help_page.dart';
import '../screens/menu drawer/teaser pages/teaser.dart';
import '../screens/module/task pages/quiz screens/quiz_outcome_screen.dart';

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
          page: () => const HomePage(),
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
          page: () => const FaqPage(),
        ),
        GetPage(
          name: "/settings",
          page: () => const SettingsPage(),
        ),
        GetPage(
          name: "/profile",
          page: () => const ProfilePage(),
        ),
        GetPage(
          name: QuestionScreen.routeName,
          page: () => const QuestionScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionController>(QuestionController());
          }),
        ),
        GetPage(
          name: QuizOutcomeScreen.routeName,
          page: () => const QuizOutcomeScreen(),
        ),
      ];
}
