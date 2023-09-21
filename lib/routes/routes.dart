import 'package:fiservonboardingexp/controllers/read_controller.dart';
import 'package:fiservonboardingexp/screens/faq_page.dart';
import 'package:fiservonboardingexp/screens/home_page.dart';
import 'package:fiservonboardingexp/screens/login_page.dart';
import 'package:fiservonboardingexp/screens/main_screen.dart';
import 'package:fiservonboardingexp/screens/manager/manager_view.dart';
import 'package:fiservonboardingexp/screens/profile_page.dart';
import 'package:fiservonboardingexp/screens/menu%20drawer/settings_page.dart';
import 'package:fiservonboardingexp/controllers/check_user.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/question_screen.dart';
import 'package:get/get.dart';
import '../controllers/quiz controllers/question_controller.dart';
import '../screens/menu drawer/help_page.dart';
import '../screens/task pages/quiz screens/quiz_outcome_screen.dart';
import '../screens/task pages/read_page.dart';
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
        // GetPage(
        //     name: QuizQuestionScreen.routeName,
        //     page: () => const QuizQuestionScreen(),
        //     binding: BindingsBuilder(() {
        //       Get.put(QuestionController());
        //     })),
      ];
}
