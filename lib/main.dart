
import 'package:daycare_app/register.dart';
import 'package:flutter/material.dart';
import 'login.dart';
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
    
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber[50], // Light grey background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'images/gambar2.png', // Replace with your image path
              height: 250, // Adjust the height as needed
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Kids Daycare!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800], // Dark brown text color
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(300, 60), // Set minimum width and height
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(300, 60), // Set minimum width and height
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
