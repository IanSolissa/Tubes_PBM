import 'package:flutter/material.dart';
import 'input_data_anak.dart'; // Import halaman InputDataAnakScreen
import 'laporan_activity_anak.dart'; // Import halaman LaporanActivityAnakScreen

class MenuScreen extends StatelessWidget {
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
                    'Input Data Anak',
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
                    MaterialPageRoute(builder: (context) => LaporanActivityAnakScreen()),
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
                    'Laporan Aktivitas Anak',
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
