import 'dart:convert';
import 'package:daycare_app/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

   bool isRegister=false; 

  void _register(BuildContext context) {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    
}

   Future<void> SubmitRegister()async{
  

if (_usernameController.text=="" || _passwordController.text=="" || _confirmPasswordController.text!=_passwordController.text) {
  print("Isi Semua Kolom...");
} else {
  try {
    final response = await http.post(Uri.parse('http://10.0.2.2/daycare_api/post_Data_user.php'),body: {
"username":_usernameController.text,
"password":_passwordController.text,
    });
   
   var $result=jsonDecode(response.body);
  if($result["status"]=="Berhasil"){
setState(() {
  
    isRegister=true;
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
          'Register',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
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
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: ()async{

              await SubmitRegister();
              if (isRegister==true) {
                print('behasil regis');
                setState(() {
                  
                isRegister==false;
                });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
 
              }
              }
              ,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Container(
                width: double.infinity,
                child: Text(
                  'Register',
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
    );
  }
}
