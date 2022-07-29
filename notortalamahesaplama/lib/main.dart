import 'package:flutter/material.dart';
import 'package:notortalamahesaplama/constants/app_constants.dart';
import 'package:notortalamahesaplama/widgets/ortalama_hesapla_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dinamik Not Ortalama",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Sabitler.anaRenk , visualDensity: VisualDensity.adaptivePlatformDensity),
      home: OrtalamaHesaplaPage(),
    );
  }
}
