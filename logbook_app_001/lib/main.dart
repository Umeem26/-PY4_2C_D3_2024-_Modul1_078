import 'package:flutter/material.dart';
import 'counter_view.dart'; // Panggil file View yang baru kita buat

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CounterView(), // Jadikan CounterView sebagai halaman utama
  ));
}