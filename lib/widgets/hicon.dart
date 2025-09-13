import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Hicon extends StatelessWidget {
  final List<List<dynamic>> icon;
  final Color? color;
  final double? size;

  const Hicon(this.icon, {super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) => HugeIcon(
    icon: icon,
    color:
        color ??
        Theme.of(context).iconTheme.color ??
        Theme.of(context).textTheme.bodyMedium?.color ??
        Colors.black,
    size: 24,
  );
}
