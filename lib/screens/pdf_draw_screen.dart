import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfDrawScreen extends StatefulWidget {
  final CameraDescription camera;
  const PdfDrawScreen({super.key, required this.camera});

  @override
  State<PdfDrawScreen> createState() => _PdfDrawScreenState();
}

class _PdfDrawScreenState extends State<PdfDrawScreen> {
  late PdfControllerPinch _pdfController;
  List<Offset> _points = [];
  bool _isDrawing = false;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/test.pdf'),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draw on PDF (pdfx)"),
        actions: [
          IconButton(
            icon: Icon(_isDrawing ? Icons.pan_tool_alt : Icons.edit),
            tooltip: _isDrawing ? 'Disable Drawing' : 'Enable Drawing',
            onPressed: () {
              setState(() {
                _isDrawing = !_isDrawing;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          PdfViewPinch(
            controller: _pdfController,
          ),
          if (_isDrawing)
            GestureDetector(
              onPanUpdate: (details) {
                RenderBox box = context.findRenderObject() as RenderBox;
                final local = box.globalToLocal(details.globalPosition);
                setState(() {
                  _points.add(local);
                });
              },
              onPanEnd: (_) => _points.add(Offset.zero),
              child: CustomPaint(
                painter: _DrawingPainter(_points),
                size: Size.infinite,
              ),
            ),
          if (!_isDrawing)
            IgnorePointer(
              ignoring: true,
              child: CustomPaint(
                painter: _DrawingPainter(_points),
                size: Size.infinite,
              ),
            ),
        ],
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<Offset> points;
  _DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DrawingPainter oldDelegate) => true;
}
