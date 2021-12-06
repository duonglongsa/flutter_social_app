import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  final String img;
  const Story({Key? key, required this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blue, width: 3)),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          backgroundImage: AssetImage("lib/assets/$img"),
        ),
      ),
    );
  }
}
