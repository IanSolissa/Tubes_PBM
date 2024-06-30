import 'dart:convert';
import 'package:daycare_app/data_anak.dart';
import 'package:daycare_app/laporan_activity_anak.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListanakOrangtua extends StatefulWidget {
  final List<dynamic> user;

  ListanakOrangtua({required this.user});

  @override
  State<ListanakOrangtua> createState() => _ListanakOrangtuaState();
}

class _ListanakOrangtuaState extends State<ListanakOrangtua> {
    late List anak = [];
  late bool statusGetAnak = false;

  Future<void> postToilet() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/daycare_api/get_Data_anak_orangtua.php'),
        body: {
          "id_orangtua": widget.user[0]['id'],
          // "id_orangtua": widget.user[0]['id'],
        },
      );

      print(response.body);

      var result = jsonDecode(response.body);

      if (response.statusCode==200) {
        print("API berhasil digunakan...");
        setState(() {
          anak=result; // Menambahkan data anak ke dalam List<Map<String, dynamic>>
          // print(anak[0]['nama_lengkap']);
          statusGetAnak = true;
        });
      } else {
        print("API gagal digunakan...");
        setState(() {
          statusGetAnak = false;
        });
      }
    } catch (e) {
      print("Terjadi error: $e");
      setState(() {
        statusGetAnak = false;
      });
    }
  }

  @override
  void initState() {
    postToilet();
    print('refresh');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // print(widget.user);
      return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anak'),
      ),
      body:ListView.builder(itemBuilder: (context,index){
         return Card(
          elevation: 4.0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            subtitle: Text(anak[index]['updated_at']),
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.child_care, color: Colors.white),
            ),
            title: Text(
              anak[index]['nama_lengkap'],
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove_red_eye, color: Color.fromARGB(255, 5, 239, 36)),
              onPressed: () async{
          null;      
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LaporanActivityAnakScreen(id_anak:anak[index]['id']),
                    // builder: (context) => LaporanActivityAnakScreen(),
                  ),
                );
              },
            ),
          ),
        );
      },itemCount: anak.length,));
   }
   
  
}
