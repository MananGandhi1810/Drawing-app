import 'package:custompainter_drawing_app/presentation/components/paint_canvas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<Color, List<Offset>>> points = [];
  List<Offset> last = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.loose,
          children: [
            CustomPaint(
              painter: PaintCanvas(
                points: points,
                color: selectedColor,
              ),
            ),
            GestureDetector(
              onPanStart: (details) {
                debugPrint('Pan Start');
                setState(() {
                  points.add({
                    selectedColor: [details.localPosition]
                  });
                });
              },
              onPanUpdate: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final Offset localOffset =
                    box.globalToLocal(details.globalPosition);
                setState(() {
                  points.last[selectedColor]!.add(localOffset);
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
                            if (points.isNotEmpty) {
                              last = points.last[selectedColor]!;
                              points.removeLast();
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
                            if (last.isNotEmpty) {
                              points.add({selectedColor: last});
                              last = [];
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
                            points = [];
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
                              child: selectedColor == color
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
            )
          ],
        ),
      ),
    );
  }
}
