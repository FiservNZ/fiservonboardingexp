import 'package:fiservonboardingexp/controllers/read_controller.dart';
import 'package:fiservonboardingexp/screens/task pages/read_page.dart';
import 'package:fiservonboardingexp/idk/read_home_page.dart';
import 'package:get/get.dart';

class ReadRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(
        name: "/",
        page: () => ReadHomePage(),
      ),
      // Add the 'read' route
      GetPage(
        name: '/read',
        page: () => ReadPage(),
        binding: BindingsBuilder(() {
          Get.put(ReadController()); // Bind your ReadController
        }),
      ),
    ];
  }
}
