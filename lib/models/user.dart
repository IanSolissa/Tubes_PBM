import 'dart:async';

import 'package:mysql1/mysql1.dart';

class Album {
   String username;
   String nama;
   String password;

   Album({
    required this.username,
    required this.nama,
    required this.password,
  });

   factory Album.fromJson(Map<String, dynamic> json) {
  return Album(
    username: json['username'] as String,
    nama: json['nama'] as String,
    password: json['password'] as String,
  );
}
}