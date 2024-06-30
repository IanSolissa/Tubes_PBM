
import 'dart:async';
import 'dart:convert';

import 'package:daycare_app/data_anak.dart';
import 'package:daycare_app/listanak_orangtua.dart';
import 'package:flutter/material.dart';
import 'input_data_anak.dart'; // Import halaman InputDataAnakScreen
import 'package:http/http.dart' as http;
class MenuScreen extends StatefulWidget {
  final List<dynamic>user;

  MenuScreen({required this.user});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  
  @override
  Widget build(BuildContext context) {
  if (widget.user[0]['isAdmin']==0) {
// ORANG TUA
    return TampilanOrangTua(widget: widget);
  } else{
// ADMIN
return DataAnakScreen(user: widget.user);
  }
  }
}

class TampilanOrangTua extends StatefulWidget {
  late List anak;
   TampilanOrangTua({
    super.key,
  
    required this.widget,
  });

  final MenuScreen widget;

  @override
  State<TampilanOrangTua> createState() => _TampilanOrangTuaState();
}

class _TampilanOrangTuaState extends State<TampilanOrangTua> {
  bool statusSelect=false;
late List<dynamic>resultanak;
  


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
            children: <Widget>[
              SizedBox(height: 150), // Memberi ruang antara AppBar dan konten
              Center(
                child: Image.asset(
                  'images/gambar2.png',
                  height: 200, // Adjust the height as needed
                ),
              ),
              SizedBox(height: 20),
              Center(child: Text("Welcome ${widget.widget.user[0]['username']}"),),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputDataAnakScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50), // Make button stretch horizontally
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8, // Adjust the width
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Daftarkan Anak Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListanakOrangtua(user: widget.widget.user)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50), // Make button stretch horizontally
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8, // Adjust the width
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Lihat Daftar Anak Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
