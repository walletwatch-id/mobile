import 'package:flutter/material.dart';

class TransitionShiftReverse extends PageRouteBuilder {
  final Widget child;
  TransitionShiftReverse({required this.child})
      : super(
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(-1.0, 0.0); 
    const end = Offset.zero; 
    final tween = Tween(begin: begin, end: end);

    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
