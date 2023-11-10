import 'dart:ui';

class LineModel {
  late List<Offset> points;
  late Color color;
  late double strokeWidth;

  LineModel({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  LineModel.fromJson(Map<String, dynamic> json) {
    points = [];
    for (var point in json['points']) {
      points.add(Offset(point[0], point[1]));
    }
    color = json['color'];
    strokeWidth = json['strokeWidth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['points'] = [];
    for (var point in points) {
      data['points'].add([point.dx, point.dy]);
    }
    data['color'] = color;
    data['strokeWidth'] = strokeWidth;
    return data;
  }
}
