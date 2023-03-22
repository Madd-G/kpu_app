import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpu_app/controllers/voter_controller.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:kpu_app/models/users.dart';

class PreviewScreen extends StatelessWidget {
  final XFile imgPath;
  final VoterModel voter;
  final int index;

  const PreviewScreen(
      {Key? key,
      required this.imgPath,
      required this.voter,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoterController voterController = Get.put(VoterController());

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(
            File(imgPath.path),
            height: MediaQuery.of(context).size.height * 0.8,
            fit: BoxFit.fitWidth,
          ),
          TextButton(
              onPressed: () async {
                var imageUrl = uploadImageFile(imagepath: imgPath.path, uid: voter.userId);
                final voterData = VoterModel(
                    id: voter.id,
                    userId: voter.userId,
                    name: voter.name,
                    nik: voter.nik,
                    phoneNumber: voter.phoneNumber,
                    gender: voter.gender,
                    date: voter.date,
                    address: voter.address,
                    imageUrl: await imageUrl);
                await voterController.updateRecord(voterData);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'))
        ],
      ),
    );
  }

  Future<String?> uploadImageFile(
      {required var imagepath, required String uid}) async {
    // String fileName = basename(imageFile.path);
    final file = File(imagepath);
    final ref =
        FirebaseStorage.instance.ref().child("imageAsset").child(uid + ".jpg");
    await ref.putFile(file);
    final imageLinkSnapshot = await ref.getDownloadURL();
    // print("url : $imageLinkSnapshot");
    if (imageLinkSnapshot != null) {
      return imageLinkSnapshot;
    }
  }
}
