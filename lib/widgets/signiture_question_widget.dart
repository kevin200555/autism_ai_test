import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';

class DrawingQuestionWidget extends StatefulWidget {
  final String question;

  const DrawingQuestionWidget({super.key, required this.question});

  @override
  State<DrawingQuestionWidget> createState() => _DrawingQuestionWidgetState();
}

class _DrawingQuestionWidgetState extends State<DrawingQuestionWidget> {
  List<Offset?> points = [];
  bool isDrawing = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionText(widget.question),
        const SizedBox(height: 10),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              final box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);

              // Only add points within the drawing canvas bounds and if isDrawing
              if (localPosition.dy >= 0 &&
                  localPosition.dy <= 300 &&
                  localPosition.dx >= 0 &&
                  localPosition.dx <= box.size.width &&
                  isDrawing) {
                points.add(localPosition);
              }
            });
          },
          onPanEnd: (_) => points.add(null), // Separate strokes
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: CustomPaint(painter: DrawingPainter(points)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() => isDrawing = !isDrawing);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.accent,
                foregroundColor: ColorTheme.alternateTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: (isDrawing)
                  ? BodyText(
                      "Stop Signing",
                      style: TextStyle(color: ColorTheme.alternateTextColor),
                      maxLines: 1,
                    )
                  : BodyText(
                      "Start Signing",
                      style: TextStyle(color: ColorTheme.alternateTextColor),
                      maxLines: 1,
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .3),
            ElevatedButton(
              onPressed: () {
                setState(() => points.clear());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.accent,
                foregroundColor: ColorTheme.alternateTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: BodyText(
                "Clear Signing",
                style: TextStyle(color: ColorTheme.alternateTextColor),
                maxLines: 1,
              ),
            ),
          ],
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
} // EOF signiture_question_widget.dart
