import 'package:flutter/material.dart';

class TransitionVerticalBottom extends PageRouteBuilder {
  final Widget child;
  TransitionVerticalBottom({required this.child})
      : super(
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0); 
    const end = Offset.zero; 
    final tween = Tween(begin: begin, end: end);

    final offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
