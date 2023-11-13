import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../r.dart';

class SimpleLoading extends StatelessWidget {
  const SimpleLoading({
    super.key,
    this.color,
    this.size,
  });

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: color ?? context.color.primary,
      size: size ?? 50,
    );
  }
}
