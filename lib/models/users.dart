import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class VoterModel with ChangeNotifier{
  String? id;
  String userId;
  String name;
  String nik;
  String phoneNumber;
  String gender;
  String date;
  String address;
  String? imageUrl;

  VoterModel({
    this.id,
    required this.userId,
    required this.name,
    required this.nik,
    required this.phoneNumber,
    required this.gender,
    required this.date,
    required this.address,
    required this.imageUrl,
  });


  toJson() {
    return {
      'uid': userId,
      'name': name,
      'nik': nik,
      'phone_number': phoneNumber,
      'gender': gender,
      'date': date,
      'address': address,
      'image_url': imageUrl,
    };
  }

  factory VoterModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return VoterModel(
      id: document.id,
      userId: data['uid'],
      name: data['name'],
      nik: data['nik'],
      phoneNumber: data['phone_number'],
      gender: data['gender'],
      date: data['date'],
      address: data['address'],
      imageUrl: data['image_url'],
    );
  }
}

// List<VoterModel> user = [
//   VoterModel(
//       id: '1',
//       userId: 'ADA3a9dd',
//       name: 'Akhmad Nur Alamsyah',
//       nik: '3382739827400001',
//       phoneNumber: '081289003940',
//       gender: 'M',
//       date: 'Saturday, February 11, 2023',
//       address: 'Desa Manamana RT 03 RW 01, Buayan, Kebumen, Jawa Tengah',
//       imageUrl: ''),
// ];
