import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  static const String routeName = 'information-screen';

  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Image.asset('assets/images/logo.png'),
              const Center(child: Text('Pemilu')),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                  'Pemilu adalah sarana pelaksanaan kedaulatan rakyat yang dilaksanakan secara langsung, umum, bebas, rahasia, jujur, dan adil dalam Negara Kesatuan Indonesia berdasarkan Pancasila dan Undang-undang Dasar Negara Republik Indonesia 1945. Pemilihan Umum yang selanjutnya disebut pemilu adalah sarana kedaulatan rakyat untuk memilih anggota Dewan Perwakilan Rakyat, anggota Dewan Perwakilan Daerah, Presiden dan Wakil Presiden, dan untuk memilih anggota Dewan Perwakilan Rakyat Daerah, yang dilaksanakan secara langsung, umum, bebas, rahasia, jujur, dan adil dalam Negara Kesatuan Republik Indonesia berdasarkan Pancasila dan Undang-Undang Dasar Negara Republik Indonesia Tahun 1945," demikian bunyi Pasal tersebut'),
            ],
          ),
        ),
      ),
    );
  }
}
