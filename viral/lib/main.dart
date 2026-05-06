import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CsvTestPage(),
    );
  }
}

class CsvTestPage extends StatefulWidget {
  @override
  State<CsvTestPage> createState() => _CsvTestPageState();
}

class _CsvTestPageState extends State<CsvTestPage> {
  String output = "Lade CSV Dateien...";

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  Future<void> loadCSV() async {
    try {
      // Fragen laden
      String fragen =
      await rootBundle.loadString('assets/fragen.csv');

      // Antworten laden
      String antworten =
      await rootBundle.loadString('assets/antworten.csv');

      setState(() {
        output =
        "FRAGEN:\n\n$fragen\n\n-------------------\n\nANTWORTEN:\n\n$antworten";
      });
    } catch (e) {
      setState(() {
        output = "Fehler beim Laden:\n$e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSV Test"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(output),
      ),
    );
  }
}