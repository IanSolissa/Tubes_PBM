import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'activity_input.dart'; // Pastikan file activity_input.dart diimpor

import 'package:http/http.dart' as http;
class DataAnakScreen extends StatefulWidget {
  @override
  _DataAnakScreenState createState() => _DataAnakScreenState();
}

class _DataAnakScreenState extends State<DataAnakScreen> {
  List<String> childrenNames = ['Anak 1', 'Anak 2', 'Anak 3'];
List<dynamic> anak=[];
Future<void> getDataAnak()async{
  final $response=await http.get(Uri.parse('http://10.0.2.2/daycare_api/get_Data_anak.php'));
   setState(() {
     
    anak=jsonDecode($response.body);
   });
 
 }

  @override
  Widget build(BuildContext context) {
  getDataAnak();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Anak Daycare',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: anak.length,
        itemBuilder: (context, index)  {
          //  getDataAnak();
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
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
                icon: Icon(Icons.edit, color: Colors.orange),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityInputScreen(id_anak: anak[index]['id'],id_orangtua: anak[index]['id_orangtua'],id_pengasuh: anak[index]['id_pengasuh'],),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getDataAnak,
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }
}
