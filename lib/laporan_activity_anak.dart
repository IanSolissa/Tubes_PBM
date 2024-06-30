
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class LaporanActivityAnakScreen extends StatefulWidget {
  final int id_anak;

LaporanActivityAnakScreen({required this.id_anak});

  @override
  State<LaporanActivityAnakScreen> createState() => _LaporanActivityAnakScreenState();
}

class _LaporanActivityAnakScreenState extends State<LaporanActivityAnakScreen> {
  late List laporan;

Future<void>selectDataLaporan()async{
  var response=await http.post(Uri.parse('http://10.0.2.2/daycare_api/get_Data_laporan_pengasuh.php'),body: {
    'id_anak':widget.id_anak.toString(),
  });
  try {
    if (response.statusCode==200||response.statusCode==201) {
     setState(() {
       
      laporan=jsonDecode(response.body);
     });
      
      print(laporan);
    }
    else{
      print("gaada");
      print(jsonDecode(response.body));
    }
  } catch (e) {
   print(e); 
  }
}

@override
void initState() {
  selectDataLaporan();
  
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Aktivitas Anak',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildInfoHeader(
                'NAME',
                'Vendyan',
                'DATE',
                '01 April 2024',
                'ARRIVAL',
                '9.40',
                'BODY TEMPERATURE',
                '36.0°C',
                'CONDITIONS',
                'Baik',
              ),
              SizedBox(height: 20),
              _buildSectionTitle('MEALS'),
              _buildMealTable(),
              SizedBox(height: 20),
              _buildSectionTitle('TOILET'),
              _buildToiletTable(),
              SizedBox(height: 20),
              _buildSectionTitle('REST'),
              _buildIstirahatTable(),
              SizedBox(height: 20),
              _buildSectionTitle('BOTTLE'),
              _buildBotolTable(),
              SizedBox(height: 20),
              _buildSectionTitle('VITAMIN'),
              _buildVitaminTable(),
              SizedBox(height: 20),
              _buildSectionTitle('SHOWER'),
              _buildShowerTable(),
              SizedBox(height: 20),
              _buildSectionTitle('ITEM I NEED'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        SizedBox(height: 5), // Menambahkan sedikit ruang antara judul dan tabel
      ],
    );
  }

  Widget _buildInfoHeader(
      String label1,
      String value1,
      String label2,
      String value2,
      String arrivalLabel,
      String arrivalValue,
      String label3,
      String value3,
      String label4,
      String value4,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildInfoText(label1, value1),
              _buildInfoText(label2, value2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildInfoText(arrivalLabel, arrivalValue),
              _buildInfoText(label3, value3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildInfoText(label4, value4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildMealTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('TYPE', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('FOOD', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('QUANTITY', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('BREAKFAST')),
          DataCell(Text('-')),
          DataCell(Text('NONE')),
        ]),
        DataRow(cells: [
          DataCell(Text('SNACK')),
          DataCell(Text('Buah-buahan')),
          DataCell(Text('LOTS')),
        ]),
        DataRow(cells: [
          DataCell(Text('LUNCH')),
          DataCell(Text('Nasi, Ayam, Sayur')),
          DataCell(Text('SOME')),
        ]),
        DataRow(cells: [
          DataCell(Text('DINNER')),
          DataCell(Text('Nasi, Ikan, Sayur')),
          DataCell(Text('LOTS')),
        ]),
        DataRow(cells: [
          DataCell(Text('FLUIDS')),
          DataCell(Text('Air putih')),
          DataCell(Text('LOTS')),
        ]),
      ],
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
      dataRowColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white),
      dividerThickness: 1,
      columnSpacing: 20,
    );
  }

  Widget _buildToiletTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('TIME', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('TIPE', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('CONDITIONS', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('11:37')),
          DataCell(Text('Diaper')),
          DataCell(Text('Wet')),
        ]),
        // Add more DataRow widgets for additional entries
      ],
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
      dataRowColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white),
      dividerThickness: 1,
      columnSpacing: 20,
    );
  }

  Widget _buildIstirahatTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('START', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('REST', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('12:59')),
          DataCell(Text('13:57')),
        ]),
        // Add more DataRow widgets for additional entries
      ],
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
      dataRowColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white),
      dividerThickness: 1,
      columnSpacing: 20,
    );
  }

  Widget _buildBotolTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('TIME', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('ML', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('BOTTLE TIPE', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('09:48')),
          DataCell(Text('1 kotak')),
          DataCell(Text('Milk')),
        ]),
        // Add more DataRow widgets for additional entries
      ],
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
      dataRowColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white),
      dividerThickness: 1,
      columnSpacing: 20,
    );
  }

  Widget _buildVitaminTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('NAME', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('MOUNT', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('TIME', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Vitamin A')),
          DataCell(Text('1 tablet')),
          DataCell(Text('08:00')),
        ]),
        // Add more DataRow widgets for additional entries
      ],
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
      dataRowColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white),
      dividerThickness: 1,
      columnSpacing: 20,
    );
  }

  Widget _buildShowerTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('SHOWER', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('TIME', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Pagi')),
          DataCell(Text('07:00')),
        ]),
        DataRow(cells: [
          DataCell(Text('Sore')),
          DataCell(Text('17:00')),
        ]),
      ],
      headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
      dataRowColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white),
      dividerThickness: 1,
      columnSpacing: 20,
    );
  }

  Widget _buildTextInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
