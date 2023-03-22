import 'package:flutter/material.dart';
import 'package:kpu_app/controllers/voter_controller.dart';
import 'package:kpu_app/ui/views/data_screen/view/voter_data_screen.dart';
import 'package:kpu_app/utils/constants.dart';
import '../../../../models/users.dart';
import 'package:get/get.dart';

class VoterListScreen extends StatelessWidget {
  static const String routeName = 'voter-list-screen';

  const VoterListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final voterController = Get.put(VoterController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Daftar Pemilih'),
        ),
        body: FutureBuilder<List<VoterModel>>(
          future: voterController.getAllVoter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return VoterListTile(
                        index: index,
                        data: snapshot.data,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: snapshot.data!.length);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error.toString()}');
              } else {
                return const Text('Error');
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class VoterListTile extends StatelessWidget {
  final int index;
  final dynamic data;

  const VoterListTile({
    required this.index,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VoterDataScreen(
                      voter: data[index],
                      index: index,
                    )));
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Container(
          height: 50,
          width: 50,
          color: const Color(Constant.mainColor),
          child: Center(
            child: Text(
              data[index].name[0],
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data[index].name),
          Text(
            data[index].phoneNumber,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
