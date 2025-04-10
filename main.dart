import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDaQhks_0ZsXc_MuGTxmlLtocI_gkxl-WY',
      authDomain: 'crud-app-2e764.firebaseapp.com',
      projectId: 'crud-app-2e764',
      storageBucket: 'crud-app-2e764.firebasestorage.app',
      messagingSenderId: '643833551553',
      appId: '1:643833551553:web:b18717e3947b3662e4d240',
      measurementId: 'G-N292NCGXZK', // ini opsional, bisa dihapus kalau error
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
    );
  }
}
