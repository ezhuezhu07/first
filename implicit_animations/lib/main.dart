import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  /* 
  Animation controller |  Actual
  0.0                      0 degree
  0.5                     180 degree  
  1.0                     360 degree
  */
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isZoomedIn = false;
  static const double defaultWidth = 100;
  var _width = defaultWidth;
  var _curve = Curves.bounceOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // Tween is Between
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: _width,
                child: Image.asset('assets/images/nature.jpg'),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isZoomedIn = !isZoomedIn;
                _width = isZoomedIn
                    ? MediaQuery.of(context).size.width
                    : defaultWidth;
                _curve = isZoomedIn ? Curves.bounceOut : Curves.bounceIn;
              });
            },
            child: Text(isZoomedIn ? 'Zoom out' : 'Zoom in'),
          ),
        ],
      ),
    );
  }
}
