import 'package:flutter/widgets.dart';
import 'package:benix/widget/router_animation.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  AnimationController? rotationController;
  Animation<double>? rotationAnimation;

  @override
  void initState() {
    super.initState();

    rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    rotationAnimation = Tween<double>(begin: 0.0, end: 10).animate(CurvedAnimation(parent: rotationController!, curve: Curves.easeInExpo)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          rotationController!.reset();
          rotationController!.forward();
        }
      }));
    rotationController!.forward();
  }

  @override
  void dispose() {
    if (rotationController != null) rotationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimateRotation(
        angle: Tween(begin: 0.0, end: 40),
        animation: rotationAnimation!,
        child: Transform.rotate(
          angle: rotationAnimation!.value,
          child: Image.asset(
            'assets/logo/logo.png',
            width: 50,
          ),
        ),
      ),
    );
  }
}
