import 'dart:convert';

import 'package:flutter/material.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'menu.dart'; // Import halaman MenuScreen

class LoginScreen extends StatefulWidget {
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late bool statusLogin=false;
  late List<dynamic> user;

Future<void> Login()async{
  

if (_usernameController.text=='' || _passwordController.text=='' ) {
  print("Isi Semua Kolom...");
} else {
  try {
    final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/login.php'),body: {
"username":_usernameController.text,
"password":_passwordController.text,
    });
  //  print(response.body);
   user=jsonDecode(response.body);
  
  print(user[0]['username']);
  if(user[0]['username']!=[]){
setState(() {

    statusLogin=true;
});
  }else{
    setState(() {
      
    statusLogin=false;
    });
    }


  } catch (e) {
    print(e);
  }
}

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 60), // Memberi ruang antara AppBar dan konten
              Image.asset(
                'images/gambar2.png',
                height: 150, // Adjust the height as needed
              ),
              SizedBox(height: 20),
              Text(
                'Login to continue',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
          
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await Login(); // Panggil fungsi Login saat tombol ditekan
                  print("STATUS LOGIN USER : ");
                  print(statusLogin);
                  if (statusLogin) {
                    print("BERHASIL MASUK KE HALAMAN....");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuScreen(user:user)),
                    );
                  } else {
                    print("ANDA BELUM LOGIN");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}
