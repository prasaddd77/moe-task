
import 'package:flutter/material.dart';

class ResultOfQrScreen extends StatefulWidget {
  final String code;

  const ResultOfQrScreen({super.key, required this.code});

  @override
  State<ResultOfQrScreen> createState() => _ResultOfQrScreenState();
}

class _ResultOfQrScreenState extends State<ResultOfQrScreen> {
  late Map<String, dynamic> qrData;

  @override
  void initState() {
    super.initState();
  }

  final bgColor = const Color(0xfffafafa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner Screen",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "QR Code Data:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
