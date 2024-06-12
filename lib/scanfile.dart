import 'package:flutter/material.dart';
import 'package:moe_qr_scanner/result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              'assets/moe.png',
              height: 100,
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.black,
                        borderRadius: 10,
                        borderWidth: 0,
                        cutOutSize: MediaQuery.of(context).size.width * 0.6,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CustomPaint(
                    size: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.width * 0.6,
                    ),
                    painter: CurvedCornerPainter(
                      borderColor: Colors.black,
                      borderWidth: 5,
                      cornerLength: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Scannen Sie den QR-Code',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Scannen Sie den QR-Code auf der Unterseite des Gateways, um die Installation fortzusetzen',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
      print(
          'Scanned QR code data: ${scanData.code} and type is ${scanData.runtimeType}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultOfQrScreen(code: scanData.code.toString()),
        ),
      );
    });
  }
}

class CurvedCornerPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double cornerLength;

  CurvedCornerPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.cornerLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    double radius = 10;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3.14,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(radius, 0),
      Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(0, radius),
      Offset(0, cornerLength),
      paint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width - radius, radius), radius: radius),
      4.71,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - radius, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, radius),
      Offset(size.width, cornerLength),
      paint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, size.height - radius), radius: radius),
      1.57,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(radius, size.height),
      Offset(cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height - radius),
      Offset(0, size.height - cornerLength),
      paint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width - radius, size.height - radius),
          radius: radius),
      0,
      1.57,
      false,
      paint,
    );
    canvas.drawLine(
      Offset(size.width - radius, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - radius),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
