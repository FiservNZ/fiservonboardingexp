import 'package:get/get.dart';
import '../../firebase references/services/firebase_storage_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseStorageService());
  }
}
