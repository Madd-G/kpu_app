import 'package:flutter/material.dart';
import 'package:kpu_app/ui/views/form_screen/view/form_screen.dart';
import 'package:kpu_app/ui/views/information_screen/view/information_screen.dart';
import 'package:kpu_app/utils/constants.dart';

import '../../data_screen/view/voter_list_screen.dart';
import '../../login_screen/view/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> menus = ['Informasi', 'Form Entry', 'Lihat Data', 'Keluar'];
    List<IconData> icons = const [
      Icons.info,
      Icons.format_align_justify_outlined,
      Icons.dataset,
      Icons.exit_to_app
    ];

    List routes = [
      InformationScreen.routeName,
      FormScreen.routeName,
      VoterListScreen.routeName,
      LoginScreen.routeName,
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('KPU'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0.0),
          child: ListView.separated(
            itemCount: menus.length,
            itemBuilder: (context, index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, routes[index]);
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(Constant.mainColor).withOpacity(0.8),
                      ),
                      child: ListTile(
                        leading: Icon(
                          icons[index],
                          size: 50.0,
                          color: Colors.white,
                        ),
                        title: Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Text(
                            menus[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
    );
  }
}
