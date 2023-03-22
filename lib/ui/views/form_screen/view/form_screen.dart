import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:kpu_app/controllers/gender_controller.dart';
import 'package:kpu_app/ui/views/home_screen/view/home_screen.dart';
import 'package:kpu_app/utils/constants.dart';
import '../widgets/gender_button.dart';

final _firestore = FirebaseFirestore.instance;

class FormScreen extends StatefulWidget {
  static const String routeName = 'form-screen';

  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nikController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    nikController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GenderController genderController = Get.put(GenderController());
    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text('Form Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'NIK',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: nikController,
                    decoration:
                        Constant.textInputDecoration.copyWith(hintText: 'NIK'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom NIK harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Nama',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration:
                        Constant.textInputDecoration.copyWith(hintText: 'Nama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom nama harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Nomor Handphone',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: Constant.textInputDecoration
                        .copyWith(hintText: 'Nomor Handphone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kolom nomor handphone harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Jenis Kelamin',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      GenderButton(index: 0, title: 'Male'),
                      GenderButton(index: 1, title: 'Female'),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _firestore.collection('voter_data').add({
                            'uid': Constant.getRandomString(8),
                            'name': usernameController.text,
                            'nik': nikController.text,
                            'phone_number': phoneNumberController.text,
                            'gender': genderController.getGender(),
                            'date':
                                '${DateFormat.jm().format(DateTime.now())}, ${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
                            'address': '',
                            'image_url': '',
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Data ditambahkan')),
                          );
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (route) => false);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
