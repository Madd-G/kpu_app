import 'package:get/get.dart';
import 'package:kpu_app/repository/voter_data_repository.dart';

import '../models/users.dart';

class VoterController extends GetxController {
  static VoterController get instance => Get.find();
  final _voterRepo = Get.put(VoterRepository());

  Future<List<VoterModel>> getAllVoter() async {
    return await _voterRepo.getAllVoter();
  }

  updateRecord(VoterModel voterModel) async {
    await _voterRepo.updateVoterRecord(voterModel);
  }

  RxString addresss = ''.obs;
}
