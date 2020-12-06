import 'package:flutter/material.dart';

class ScreenFadeTransition extends StatefulWidget {
  final Widget destinationPage;
  final Duration duration;

  const ScreenFadeTransition(
      {Key key,
      @required this.destinationPage,
      this.duration = const Duration(seconds: 1)})
      : super(key: key);

  @override
  _ScreenFadeTransitionState createState() => _ScreenFadeTransitionState();
}

class _ScreenFadeTransitionState extends State<ScreenFadeTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.ease)).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Container(
      color: Color(0xFF8185E2),
      child: FadeTransition(
        opacity: _animation,
        child: widget.destinationPage,
      ),
    );
  }
}
