import 'package:flutter/material.dart';

class CustomLargeCardCenterTitle extends StatelessWidget {
  final String image;
  final String title;
  const CustomLargeCardCenterTitle({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.35,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
      ),
    );
  }
}
