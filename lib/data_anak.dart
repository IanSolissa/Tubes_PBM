import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'activity_input.dart'; // Pastikan file activity_input.dart diimpor
import 'package:auto_spacing/auto_spacing.dart';
import 'package:http/http.dart' as http;
class DataAnakScreen extends StatefulWidget {
  final List<dynamic>user;
  DataAnakScreen({required this.user});


  @override
  _DataAnakScreenState createState() => _DataAnakScreenState(anak:this.user);
}

class _DataAnakScreenState extends State<DataAnakScreen> {
List<dynamic> anak;
  _DataAnakScreenState({required this.anak});
  // List<String> childrenNames = ['Anak 1', 'Anak 2', 'Anak 3'];
Future<void>selectDataPengasuh()async{
  var response=await http.post(Uri.parse('http://10.0.2.2/daycare_api/get_Data_anak_pengasuh.php'),body: {
    'id_pengasuh':anak[0]['id'],
  });
  try {
    if (response.statusCode==200||response.statusCode==201) {
     setState(() {
       
      anak=jsonDecode(response.body);
     });
      
      print(anak);
    }
    else{
      print("gaada");
      print(jsonDecode(response.body));
    }
  } catch (e) {
   print(e); 
  }
}
Future<void> getDataAnak()async{
  final $response=await http.get(Uri.parse('http://10.0.2.2/daycare_api/get_Data_anak.php'));
   setState(() {
     
    anak=jsonDecode($response.body);
   });
 
 }

  @override

  Widget build(BuildContext context) {

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
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(style: TextButton.styleFrom(backgroundColor: Colors.orange), onPressed: () async{
           await getDataAnak();
          print("cekanak");
          // print(anak);
          if (anak.length<0) {
           
          }
          else{

          Navigator.push(context,MaterialPageRoute(builder: (context)=>ListAnak(anak: anak)));
          }
        }, child: const Text("Lihat Semua Anak",style: TextStyle(color: Colors.white,fontSize:20 ))),
      ),Padding(
        padding: const EdgeInsets.all(10.0),
        child: 
        TextButton(style: TextButton.styleFrom(backgroundColor: Colors.orange), onPressed: () async{
           await selectDataPengasuh();
          print("cekanak");
          // print(anak);
          if (anak.length<0) {
           
          }
          else{

          Navigator.push(context,MaterialPageRoute(builder: (context)=>ListAnak(anak: anak)));
          }
        }, child: const Text("Lihat Anak Yang Anda Asuh",style: TextStyle(color: Colors.white,fontSize:20 ))),
      ),
        ],),),
      // Button gausah dipake karna hanya orang tua saja yang bisa daftar anak
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getDataAnak,
      //   backgroundColor: Colors.orange,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class ListAnak extends StatefulWidget {
  const ListAnak({
    super.key,
    required this.anak,
  });

  final List<dynamic> anak;

  @override
  State<ListAnak> createState() => _ListAnakState();
}

class _ListAnakState extends State<ListAnak> {
  @override
  Widget build(BuildContext context) {
   if (widget.anak.length>0) {
      return Scaffold(
      
      appBar: 
      AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: 
        Text('Lihat Semua Data'),),
        body: ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.anak.length,
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
              widget.anak[index]['nama_lengkap'],
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: () async{
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityInputScreen(anak: widget.anak,id_pengasuh: widget.anak[index]['id_pengasuh'],),
                  ),
                );
              },
            ),
          ),
        );
      },
    ),);
   } else {
      return Scaffold(
      
      appBar: 
      AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: 
        Text('Lihat Semua Data'),),
        body: 
        Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.close,size: 75,color: Colors.red,),Text('404 Data Not Found...')],),)
        );
   }
  }
}
