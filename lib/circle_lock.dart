import 'package:flutter/material.dart';

class CircleLock extends StatefulWidget {
  const CircleLock({super.key});

  @override
  State<CircleLock> createState() => _CircleLockState();
}

class _CircleLockState extends State<CircleLock> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFfff5e9),
      ),
      child: const Icon(
        Icons.lock,
        size: 15,
        color: Color(0xFFe5be90),
      ),
    );
  }
}