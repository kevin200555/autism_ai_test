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
  final GlobalKey _canvasKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionText(widget.question),
          const SizedBox(height: 10),
          GestureDetector(
            onPanUpdate: (details) {
              final box = _canvasKey.currentContext?.findRenderObject();
              if (box is RenderBox) {
                final localPosition = box.globalToLocal(details.globalPosition);

                final withinBounds =
                    localPosition.dy >= 0 &&
                    localPosition.dy <= box.size.height &&
                    localPosition.dx >= 0 &&
                    localPosition.dx <= box.size.width;

                if (withinBounds) {
                  setState(() => points.add(localPosition));
                }
              }
            },
            onPanEnd: (_) => points.add(null),
            child: Container(
              key: _canvasKey,
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.15,
              decoration: BoxDecoration(
                border: Border.all(color: ColorTheme.textColor),
                color: ColorTheme.background,
              ),
              child: CustomPaint(painter: DrawingPainter(points)),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
                width: MediaQuery.sizeOf(context).width * 0.30,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => points.clear());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.red,
                    foregroundColor: ColorTheme.alternateTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                    child: AppBarTitle(
                      "CLEAR",
                      color: ColorTheme.background,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorTheme.textColor
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
