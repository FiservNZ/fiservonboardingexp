import 'package:get/get.dart';
import '../../firebase references/services/firebase_storage_service.dart';
import '../../idk/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    //Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => FirebaseStorageService());
  }
}
