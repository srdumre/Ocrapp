import 'package:flutter/material.dart';

class BackDropGesture extends StatelessWidget {
  final Function()? onTap;
  final child;
  final double? radius;
  const BackDropGesture({super.key, this.onTap, this.child, this.radius});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
          splashColor: Colors.blue.withOpacity(0.2),
          highlightColor: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(radius ?? 0),
          onTap: onTap,
          child: child),
    );
  }
}
