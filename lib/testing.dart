import 'dart:convert';

import 'package:daycare_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Testing extends StatefulWidget {
  

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  TextEditingController username = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController password = TextEditingController();
  
 Future<void> deleteAlbum() async {
  if (username.text == '') {
    print("Isi Username untuk menghapus data...");
  } else {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/daycare_api/delete_Data.php'), // Sesuaikan dengan URL delete_Data.php yang sesuai
        body: {
          "username": username.text,
        },
      );

      var result = jsonDecode(response.body);
      if (result["status"] == "Berhasil") {
        print("Data dengan username ${username.text} berhasil dihapus");
      } else {
        print("Gagal menghapus data: ${result["message"]}");
      }

    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }
}


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Testing Input'),),
  body: Column(
    children: [
      TextFormField(
        controller: username,
        decoration: InputDecoration(label: Text('Test Input')
        ),
        ),
        TextFormField(
          controller: nama,
        decoration: InputDecoration(label: Text('Test Input')),
        ),
        TextFormField(
          controller: password,
        decoration: InputDecoration(label: Text('Test Input')),
        ),
        TextButton(onPressed: deleteAlbum, child: Text('Submit')),
        ]));
  }
  }