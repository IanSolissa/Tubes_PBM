import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class LaporanActivityAnakScreen extends StatefulWidget {
  final String id_anak;

  LaporanActivityAnakScreen({required this.id_anak});

  @override
  State<LaporanActivityAnakScreen> createState() => _LaporanActivityAnakScreenState();
}

class _LaporanActivityAnakScreenState extends State<LaporanActivityAnakScreen> {
  late Map<String, dynamic> jsonData = {};

  Future<void> selectDataLaporan() async {
    var response = await http.post(
      Uri.parse('http://10.0.2.2/daycare_api/get_Data_laporan_pengasuh.php'),
      body: {'id_anak': widget.id_anak},
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          jsonData = jsonDecode(response.body);
        });
      } else {
        print("Data not found");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    selectDataLaporan();
  }


  @override
  Widget build(BuildContext context) {
    if (jsonData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Laporan Aktivitas Anak'),
          backgroundColor: Colors.orange,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

  final dataMap = <String, double>{
    "Meals": jsonData['meal'].length.toDouble() ,
    "Toilet": jsonData['toilet'].length.toDouble() ,
    "Rest": jsonData['rest'].length.toDouble() ,
    "Bottle": jsonData['rest'].length.toDouble() ,
    "Vitamin": jsonData['vitamin'].length.toDouble() ,
    "Item Needs": jsonData['item'].length.toDouble() ,
  };
  final colorList = <Color>[
    Colors.greenAccent,
    const Color.fromARGB(255, 30, 94, 63),
    Color.fromARGB(255, 70, 2, 196),
    Color.fromARGB(255, 112, 7, 87),
    Color.fromARGB(205, 157, 31, 31),
    Color.fromARGB(151, 9, 106, 141),
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Aktivitas Anak'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.grey[300]!,
          colorList: colorList,
        ),
      ),
              _buildInfoHeader(),
              SizedBox(height: 20),
              _buildMealsSection(),
              SizedBox(height: 20),
              _buildToiletSection(),
              SizedBox(height: 20),
              _buildRestSection(),
              SizedBox(height: 20),
              _buildBottleSection(),
              SizedBox(height: 20),
              _buildShowerSection(),
              SizedBox(height: 20),
              _buildVitaminSection(),
              SizedBox(height: 20),
              _buildItemNeedsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Nama', jsonData['laporan'][0]['id_anak'] ?? ''),
          _buildInfoRow('Arrival', jsonData['laporan'][0]['arrival_time'] ?? ''),
          _buildInfoRow('Kondisi', jsonData['laporan'][0]['kondisi'] ?? ''),
          _buildInfoRow('Tanggal', jsonData['laporan'][0]['timestamp'] ?? ''),
          _buildInfoRow('Suhu Tubuh', '${jsonData['laporan'][0]['temperature'] ?? ''}°C'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(content),
        ],
      ),
    );
  }

  Widget _buildMealsSection() {
    return _buildSectionWithTable(
      'Makanan',
      jsonData['meal'] ?? [],
      ['comment', 'Food', 'Quantity'],
      (meal) => [
        DataCell(Text(meal['comment'] ?? '')),
        DataCell(Text(meal['food'] ?? '')),
        DataCell(Text(meal['quantity'] ?? '')),
      ],
    );
  }

  Widget _buildToiletSection() {
    return _buildSectionWithTable(
      'Toilet',
      jsonData['toilet'] ?? [],
      ['Waktu', 'Jenis', 'Kondisi'],
      (entry) => [
        DataCell(Text(entry['waktu'] ?? '')),
        DataCell(Text(entry['type'] ?? '')),
        DataCell(Text(entry['kondisi'] ?? '')),
      ],
    );
  }

  Widget _buildRestSection() {
    return _buildSectionWithTable(
      'Istirahat',
      jsonData['rest'] ?? [],
      ['Mulai Istirahat', 'Akhir Istirahat'],
      (entry) => [
        DataCell(Text(entry['start_time'] ?? '')),
        DataCell(Text(entry['end_time'] ?? '')),
      ],
    );
  }

  Widget _buildBottleSection() {
    return _buildSectionWithTable(
      'Botol',
      jsonData['bottle'] ?? [],
      ['Waktu', 'ML', 'Tipe'],
      (entry) => [
        DataCell(Text(entry['time'] ?? '')),
        DataCell(Text(entry['ML'] ?? '')),
        DataCell(Text(entry['type'] ?? '')),
      ],
    );
  }

  Widget _buildVitaminSection() {
    return _buildSectionWithTable(
      'Vitamin',
      jsonData['vitamin'] ?? [],
      ['Nama', 'Jumlah', 'Waktu'],
      (entry) => [
        DataCell(Text(entry['vitamin_name'] ?? '')),
        DataCell(Text(entry['amount'] ?? '')),
        DataCell(Text(entry['time'] ?? '')),
      ],
    );
  }

Widget _buildShowerSection() {
  if (jsonData['shower'] != null && jsonData['shower'].isNotEmpty) {
    final showerData = jsonData['shower'][0]; // Assuming you want the first entry in the list

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Mandi'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pagi', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(showerData['morning_shower'] ?? '-', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Siang', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(showerData['evening_shower'] ?? '-', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  } else {
    return _buildSectionTitle('Mandi: Data not available');
  }
}
  Widget _buildItemNeedsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Catatan Untuk Orang Tua'),
        for (var item in jsonData['item'] ?? [])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('${item['key'] ?? ''}: ${item['quantity'] ?? ''}'),
          ),
      ],
    );
  }

  Widget _buildSectionWithTable(
      String title, List<dynamic> data, List<String> columns, Function(dynamic) buildCells) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        DataTable(
          columns: columns.map((col) => DataColumn(label: Text(col, style: TextStyle(fontWeight: FontWeight.bold)))).toList(),
          rows: data.map((entry) => DataRow(cells: buildCells(entry))).toList(),
          headingRowColor: MaterialStateProperty.resolveWith((states) => Colors.orange[100]),
          dataRowColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected) ? Colors.orange[50] : Colors.white,
          ),
          dividerThickness: 1,
          columnSpacing: 20,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
    );
  }
}