// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AreaCalculator());
  }
}

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  List<String> shapes = [
    'Triangle',
    "Rectangle",
    "Circle"
  ];
  final TextEditingController widthContoller = TextEditingController();
  final TextEditingController heightContoller = TextEditingController();

  late String currentShape;
  String result = "0";
  double width = 0;
  double height = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    result = "0";
    currentShape = "Rectangle";
    widthContoller.addListener(updateWidth);
    heightContoller.addListener(updateHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Area Calculator"),
          ),
          body: Center(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                DropdownButton<String>(
                  value: currentShape,
                  items: shapes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (shape) {
                    setState(() {
                      currentShape = shape ?? currentShape;
                    });
                  },
                ),

                ShapeContainer(shape: currentShape),

                AreaTextInput(
                    controller: heightContoller, hint: "Enter shape height"),
                AreaTextInput(
                    controller: widthContoller, hint: "Enter shape weight"),
                Container(
                    child: Center(
                  child: ElevatedButton(
                    onPressed: calculateArea,
                    child: Text("Calculate area"),
                  ),
                )),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void calculateArea() {
    double area;
    if (currentShape == "Rectangle") {
      area = width * height;
    } else if (currentShape == "Triangle") {
      area = width * height / 2;
    } else if(currentShape == "Circle") {
      area = width / 3;
    }else {
      area = 0;
    }

    setState(() {
      result = "Your calculated area is " + area.toString();
    });
  }

  void updateWidth() {
    if (widthContoller.text != "") {
      width = double.parse(widthContoller.text);
    } else {
      width = 0;
    }
  }

  void updateHeight() {
    if (heightContoller.text != "") {
      height = double.parse(heightContoller.text);
    } else {
      height = 0;
    }
  }
}

class AreaTextInput extends StatelessWidget {
  AreaTextInput({required this.controller, required this.hint});

  TextEditingController controller = TextEditingController();
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (_) {},
        style: TextStyle(color: Colors.green),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.apps),
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade200,
            constraints: BoxConstraints(maxWidth: 300)),
      ),
    ));
  }
}

class ShapeContainer extends StatelessWidget {
  const ShapeContainer({required this.shape, super.key});

  final String shape;

  @override
  Widget build(BuildContext context) {
    if (shape == "Triangle") {
      return CustomPaint(
        size: Size(100, 100),
        painter: TriangleShape(),
      );
    } else if(shape == "Rectangle"){
      return CustomPaint(
        size: Size(100, 100),
        painter: RectangleSHape(),
      );
    } else {
      return CustomPaint(
        size: Size(100, 100),
        painter: CircleShape(),
      );
    }

    return Container();
  }
}

class TriangleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.deepOrange;

    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class RectangleSHape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();
    paint.color = Colors.green;

    Rect rect =
        Rect.fromLTRB(0, size.height / 4, size.width, size.height / 4 * 3);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class CircleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();
    final center = Offset(size.width/2, size.height/2);
    paint.color = Colors.deepPurple;
    final radius = size.width/3;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}
