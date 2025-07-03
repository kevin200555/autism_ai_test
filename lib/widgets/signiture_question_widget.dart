import 'package:flutter/material.dart';

class DrawingQuestionWidget extends StatefulWidget {
  final String question;

  const DrawingQuestionWidget({super.key, required this.question});

  @override
  _DrawingQuestionWidgetState createState() => _DrawingQuestionWidgetState();
}

class _DrawingQuestionWidgetState extends State<DrawingQuestionWidget> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox box = context.findRenderObject() as RenderBox;
              points.add(box.globalToLocal(details.globalPosition));
            });
          },
          onPanEnd: (_) => points.add(null), // Separate strokes
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
            child: CustomPaint(
              painter: DrawingPainter(points),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() => points.clear());
          },
          child: const Text("Clear Drawing"),
        ),
      ],
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
