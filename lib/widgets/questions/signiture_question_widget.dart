import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

// This class' creates a widget that is meant to get some drawn response from the user
// It is used to get user's signitures
class DrawingQuestionWidget extends StatefulWidget {
  final String question;
  final Function(bool) onChanged;
  final bool? value;
  const DrawingQuestionWidget({
    super.key,
    required this.question,
    required this.onChanged,
    this.value,
  });

  @override
  State<DrawingQuestionWidget> createState() => _DrawingQuestionWidgetState();
}

class _DrawingQuestionWidgetState extends State<DrawingQuestionWidget> {
  List<Offset?> points = [];
  // saves the drawn answers (like the controller for short answer question)
  final GlobalKey _canvasKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // sets a bounding box for this widget
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // returns a coloum of the quesetion on top, followed an answer box where the user can draw/erase their answer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // question text
          QuestionText(widget.question),
          const SizedBox(height: 10),
          // box that makes the answer box
          GestureDetector(
            onPanUpdate: (details) {
              final box = _canvasKey.currentContext?.findRenderObject();
              if (box is RenderBox) {
                final localPosition = box.globalToLocal(details.globalPosition);
                // sets bounds and position of cursor
                final withinBounds =
                    localPosition.dy >= 0 &&
                    localPosition.dy <= box.size.height &&
                    localPosition.dx >= 0 &&
                    localPosition.dx <= box.size.width;
                // updates if cursor is within the bounds
                if (withinBounds) {
                  widget.onChanged(true);
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
          // Row that contains the button which will erase the answer box
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
                width: MediaQuery.sizeOf(context).width * 0.20,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onChanged(false);
                    setState(() => points.clear());
                  },
                  // clear button, removes the drawing
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.red,
                    foregroundColor: ColorTheme.alternateTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.delete, size: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CustomPainter that draws the user's signature or drawing on the canvas
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    // Set up the paint style for drawing lines
    final paint = Paint()
      ..color = ColorTheme.textColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // Iterate through the list of points and draw lines between consecutive points
    for (int i = 0; i < points.length - 1; i++) {
      // Only draw if both points are not null (null indicates a break in the drawing)
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  // Always repaint when notified, since the points may have changed
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
} // EOF signiture_question_widget.dart
