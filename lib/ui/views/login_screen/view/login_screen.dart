import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpu_app/ui/views/home_screen/view/home_screen.dart';

import '../../../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool checkBox = false;
  bool _showHidePass = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height * 0.050,
              ),
              const Center(
                  child: Text(
                'Selamat Datang',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
              )),
              const Center(
                  child: Text('Silahkan masuk dengan akun anda',
                      style: TextStyle(fontSize: Constant.fontRegular))),
              const SizedBox(
                height: 50.0,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: Constant.fontRegular,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: size.height * 0.018,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF7F7F7),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFF6F6F6))),
                            hintText: 'mail@mail.com',
                            hintStyle: TextStyle(),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFF6F6F6))),
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        validator: (String? value) {
                          const String expression = "[a-zA-Z0-9+._%-+]{1,256}"
                              "\\@"
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
                              "("
                              "\\."
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}"
                              ")+";
                          final RegExp regExp = RegExp(expression);
                          return !regExp.hasMatch(value!)
                              ? "Silakan, masukkan email yang valid!"
                              : null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.018,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: Constant.fontRegular,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: size.height * 0.018,
                      ),
                      TextFormField(
                          controller: passwordController,
                          obscureText: _showHidePass,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: _showHidePass
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () => {
                                  setState(
                                    () {
                                      _showHidePass = !_showHidePass;
                                    },
                                  )
                                },
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF7F7F7),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFF6F6F6))),
                              hintText: '1234********',
                              hintStyle: const TextStyle(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFE9EBEF))),
                              contentPadding: const EdgeInsets.all(12.0),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan isi kolom kata sandi!';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: size.height * 0.018,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                side:
                                    const BorderSide(color: Color(0xFFC5C5C5)),
                                value: checkBox,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkBox = value!;
                                  });
                                },
                              ),
                              const Text('Ingat saya',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.018,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                                if (context.mounted) {
                                  await Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                      (route) => false);
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  // print('e.code ${e.code}');
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('No user found for that email.'),
                                    duration: Duration(milliseconds: 1000),
                                  ));
                                } else if (e.code == 'wrong-passw.comord') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Wrong password provided for that user.'),
                                    duration: Duration(milliseconds: 1000),
                                  ));
                                }
                              } catch (e) {
                                // print('catch: $e');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Fill out the entire form'),
                                  duration: Duration(milliseconds: 1000),
                                ));
                              }
                            }
                          },
                          child: const Text('MASUK')),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
