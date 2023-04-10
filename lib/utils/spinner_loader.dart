import 'package:flutter/material.dart';

class SpinnerLoader extends StatefulWidget {
  @override
  _SpinnerLoaderState createState() => _SpinnerLoaderState();
}

class _SpinnerLoaderState extends State<SpinnerLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: ProgressIndicatorDemo(),
      ),
    );
  }
}

class ProgressIndicatorDemo extends StatefulWidget {

  @override
  _ProgressIndicatorDemoState createState() =>
     _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 30), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(({isLoading}) {
        setState(() {
          _isLoading = false;
        });
      });
    controller.repeat();
  }


  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LinearProgressIndicator( value:  animation.value,)
    );
  }

}