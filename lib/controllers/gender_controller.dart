import 'package:get/get.dart';

class GenderController extends GetxController {
  RxInt selectedGender = 0.obs;

  String getGender() {
    return (selectedGender.value == 0) ? 'Male' : 'Female';
  }
}