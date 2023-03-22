import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpu_app/controllers/voter_controller.dart';
import 'package:kpu_app/services/geolocator_service.dart';
import 'package:kpu_app/ui/views/data_screen/view/preview_screen.dart';
import '../../../../models/users.dart';
import 'package:get/get.dart';

class VoterDataScreen extends StatelessWidget {
  final VoterModel? voter;
  final int? index;

  const VoterDataScreen({Key? key, this.voter, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    Size size = MediaQuery.of(context).size;
    GeoLocatorService geoLocatorService = GeoLocatorService();
    VoterController voterController =
        Get.put<VoterController>(VoterController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Data Pemilih'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Center(
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  voter!.name,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Pemilih',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('NIK:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  Text(
                    voter!.nik,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Nomor Handphone:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  Text(
                    voter!.phoneNumber,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Jenis Kelamin:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  Text(
                    voter!.gender,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Alamat:',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () async {
                          voterController.addresss.value =
                              (await geoLocatorService.getCurrentAddress())!;
                          // if (context.mounted) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => AnimationScreen()));
                          // }

                          final voterData = VoterModel(
                              id: voter!.id,
                              userId: voter!.userId,
                              name: voter!.name,
                              nik: voter!.nik,
                              phoneNumber: voter!.phoneNumber,
                              gender: voter!.gender,
                              date: voter!.date,
                              address: voterController.addresss.value,
                              imageUrl: voter!.imageUrl);
                          await voterController.updateRecord(voterData);
                        },
                        child: const Text('Dapatkan alamat'),
                      ),
                    ],
                  ),
                  Text(
                    (voter!.address != '')
                        ? voter!.address
                        : 'Belum ada alamat',
                    style: const TextStyle(fontSize: 18.0),
                  ),

                  // (user.address != '')
                  //     ? Text(
                  //         user.address,
                  //         style: const TextStyle(fontSize: 18.0),
                  //       )
                  //     : const Text('Belum ada alamat'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text('Gambar:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500)),
                  TextButton(
                      onPressed: () async {
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.camera);
                        if (context.mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PreviewScreen(
                                        imgPath: photo!,
                                        voter: voter!,
                                        index: index!,
                                      )));
                        }
                      },
                      child: const Text('Ambil gambar')),
                  SizedBox(
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                    child: (voter!.imageUrl != '')
                        ? Image.network(voter!.imageUrl!)
                        : const Text('Belum ada photo'),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Tanggal pendataan: ${voter!.date}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
