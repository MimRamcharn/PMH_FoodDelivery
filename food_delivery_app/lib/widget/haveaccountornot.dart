import 'package:flutter/material.dart';

class HaveAccountOrNot extends StatelessWidget {
  final String title, subTitle;
  final VoidCallback onTap;

  const HaveAccountOrNot(
      {super.key, required this.onTap, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
