import 'dart:convert';

import 'package:daycare_app/login.dart';
import 'package:daycare_app/menu.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class InputDataAnakScreen extends StatefulWidget {
  final List user;
  InputDataAnakScreen({required this.user});
  @override
  
  _InputDataAnakScreenState createState() => _InputDataAnakScreenState();
}

class _InputDataAnakScreenState extends State<InputDataAnakScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kontakNamaController = TextEditingController();
  final TextEditingController _hubunganController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _riwayatMedisController = TextEditingController();
  String? _selectedJenisKelamin;

  // void _submitData(BuildContext context) {
  //   // Logika untuk menyimpan data anak
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Data anak berhasil disimpan')),
  //   );

  //   // Navigasi ke halaman laporan aktivitas anak
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => LaporanActivityAnakScreen()),
  //   );
  // }

late bool status=false;
Future<void> InputAnak()async{
  

// if (_namaController.text=='' || _alamatController.text==''||_hubunganController.text==''||_kontakNamaController.text==''||_tanggalLahirController.text=='' ) {
if (_namaController.text=='' ) {
  print("Isi Semua Kolom...");
} else {
  try {
    final String id="1";
    final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/post_Data_anak.php'),body: {
"nama_lengkap":_namaController.text,
"tanggal_lahir":_tanggalLahirController.text,
"jenis_kelamin":_selectedJenisKelamin,
"alamat_rumah":_alamatController.text,
"nama_darurat":_kontakNamaController.text,
"hubungan_darurat":_hubunganController.text,
"nomor_darurat":_nomorTeleponController.text,
"riwayat_medis":_riwayatMedisController.text,
"id_orangtua":widget.user[0]['id'].toString(),
"id_pengasuh":'2',
    });
   
   print(response.body);
   var $result=jsonDecode(response.body);
    // print("----------------------------------------------------------------");
  if($result["status"]=="Berhasil"){
print("MASUKKK");
setState(() {
  
    status=true;
});
  }else{
    print("GAK MASUKKKK");
    setState(() {
      
    status=false;
    });
    }


  } catch (e) {
    print("GA MASUKK");
    print(e);
  }
}

}


  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.orange,
            colorScheme: ColorScheme.light(primary: Colors.orange, secondary: Colors.orange),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _tanggalLahirController.text = "${pickedDate.toLocal()}".split(' ')[0];
        print(_tanggalLahirController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Input Data Anak',
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
              _buildSectionTitle('Informasi Pribadi Anak'),
              _buildTextField(_namaController, 'Nama lengkap', Icons.person),
              _buildDateField(context),
              _buildDropdownJenisKelamin(),
              _buildTextField(_alamatController, 'Alamat rumah', Icons.home),
              SizedBox(height: 20),
              _buildSectionTitle('Informasi Kontak Darurat'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildTextField(_kontakNamaController, 'Nama kontak', Icons.person),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(_hubunganController, 'Hubungan', Icons.family_restroom),
                  ),
                ],
              ),
              _buildTextField(_nomorTeleponController, 'Nomor telepon darurat', Icons.phone),
              SizedBox(height: 20),
              _buildSectionTitle('Riwayat Medis'),
              _buildTextField(_riwayatMedisController, 'Riwayat medis anak', Icons.medical_services),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async{
                    // print( _namaController.text );
  
  // print( _hubunganController.text );
  // print( _nomorTeleponController.text );
  // print( _riwayatMedisController.text );
  // print(_selectedJenisKelamin);
                  await InputAnak();
                  if (status) {
                    Navigator.pop(context);
                    print("BERRHASSSIIILLLLLLLL");
                  }
                  else{
                    print("SGGGAAGGAAALLLLL");
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(fontSize: 16), // Add this line to ensure consistency
      ),
    );
  }

  Widget _buildDropdownJenisKelamin() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: _selectedJenisKelamin,
        decoration: InputDecoration(
          labelText: 'Jenis kelamin',
          prefixIcon: Icon(Icons.transgender),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: ['Laki-laki', 'Perempuan']
            .map((label) => DropdownMenuItem(
          child: Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          value: label,
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedJenisKelamin = value;
          });
        },
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: _tanggalLahirController,
        decoration: InputDecoration(
          labelText: 'Tanggal lahir',
          prefixIcon: Icon(Icons.calendar_today),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
        style: TextStyle(fontSize: 16), // Add this line to ensure consistency
      ),
    );
  }
}
