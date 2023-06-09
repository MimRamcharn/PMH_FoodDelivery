import 'package:flutter/material.dart';

class Gender extends StatefulWidget {
  final bool isMale;
  final VoidCallback onTap;

  const Gender({super.key, required this.isMale, required this.onTap});

  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: const Color(0xfff5d8e4), borderRadius: BorderRadius.circular(10)),
        child: Text(
          widget.isMale == false ? "Female" : "Male",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
