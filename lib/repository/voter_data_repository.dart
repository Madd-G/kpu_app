import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';

class VoterRepository extends GetxController {
  static VoterRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<VoterModel> getVoterDetail(String email) async {
    final snapshot = await _db
        .collection("voter_data")
        .where("email", isEqualTo: email)
        .get();
    final voterData = snapshot.docs.map((e) => VoterModel.fromSnapshot(e)).single;
    return voterData;
  }

  Future<List<VoterModel>> getAllVoter() async {
    final snapshot = await _db
        .collection("voter_data")
        .orderBy('timestamp', descending: true)
        .get();
    final voterData =
        snapshot.docs.map((e) => VoterModel.fromSnapshot(e)).toList();
    return voterData;
  }

  Future<void> updateVoterRecord(VoterModel voterModel) async {
    await _db
        .collection('voter_data')
        .doc(voterModel.id)
        .update(voterModel.toJson());
  }
}
