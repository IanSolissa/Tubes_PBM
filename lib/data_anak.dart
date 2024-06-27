import 'package:flutter/material.dart';
import 'activity_input.dart'; // Pastikan file activity_input.dart diimpor

class DataAnakScreen extends StatefulWidget {
  @override
  _DataAnakScreenState createState() => _DataAnakScreenState();
}

class _DataAnakScreenState extends State<DataAnakScreen> {
  List<String> childrenNames = ['Anak 1', 'Anak 2', 'Anak 3'];

  void _addChild() {
    // Logika untuk menambahkan anak baru
    setState(() {
      childrenNames.add('Anak Baru');
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: childrenNames.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.child_care, color: Colors.white),
              ),
              title: Text(
                childrenNames[index],
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
                      builder: (context) => ActivityInputScreen(childName: childrenNames[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addChild,
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }
}
