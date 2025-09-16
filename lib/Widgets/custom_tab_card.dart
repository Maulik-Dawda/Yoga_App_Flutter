import 'package:flutter/material.dart';

class CustomTabCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const CustomTabCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.3,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      child: Text(
                        subtitle,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                    const Positioned(
                      bottom: 12,
                      child: Icon(Icons.play_circle_outline,
                          color: Colors.white, size: 30),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
