import 'package:custompainter_drawing_app/presentation/components/paint_canvas.dart';
import 'package:flutter/material.dart';

import '../models/line_model.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<LineModel> lines = [
    LineModel(points: [], color: Colors.red, strokeWidth: 5)
  ];
  LineModel last = LineModel(points: [], color: Colors.red, strokeWidth: 5);
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.black,
    Colors.white,
  ];
  Color selectedColor = Colors.red;
  double selectedStrokeWidth = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.loose,
          children: [
            CustomPaint(
              painter: PaintCanvas(
                lines: lines,
                color: selectedColor,
              ),
            ),
            GestureDetector(
              onPanStart: (details) {
                debugPrint('Pan Start');
                setState(
                  () {
                    lines.add(
                      LineModel(
                        points: [details.localPosition],
                        color: selectedColor,
                        strokeWidth: selectedStrokeWidth,
                      ),
                    );
                  },
                );
              },
              onPanUpdate: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final Offset localOffset =
                    box.globalToLocal(details.globalPosition);
                setState(() {
                  lines.last.points.add(localOffset);
                  lines.last.color = selectedColor;
                });
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          debugPrint('Undo');
                          setState(() {
                            if (lines.isNotEmpty) {
                              last = lines.last;
                              lines.removeLast();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.undo,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          debugPrint('Redo');
                          setState(() {
                            if (last.points.isNotEmpty) {
                              lines.add(last);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.redo,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          debugPrint('Clear');
                          setState(() {
                            lines.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var color in colors)
                          GestureDetector(
                            onTap: () {
                              debugPrint(color.toString());
                              setState(() {
                                selectedColor = color;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 20,
                              child: selectedColor.withOpacity(1) ==
                                      color.withOpacity(1)
                                  ? Icon(
                                      Icons.check,
                                      color: selectedColor == Colors.black
                                          ? Colors.white
                                          : Colors.black,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Slider(
                            label: "Opacity: ${selectedColor.opacity}",
                            value: selectedColor.opacity,
                            min: 0,
                            max: 1,
                            inactiveColor: selectedColor.withOpacity(0.5),
                            activeColor: selectedColor,
                            onChanged: (value) {
                              setState(() {
                                selectedColor =
                                    selectedColor.withOpacity(value);
                              });
                            },
                          ),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Slider(
                            label: "Stroke Width: $selectedStrokeWidth",
                            value: selectedStrokeWidth,
                            min: 1,
                            max: 10,
                            inactiveColor: selectedColor.withOpacity(0.5),
                            activeColor: selectedColor,
                            onChanged: (value) {
                              setState(() {
                                selectedStrokeWidth = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
