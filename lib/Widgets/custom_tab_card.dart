import 'package:flutter/material.dart';

class CustomTabCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const CustomTabCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 12,
            bottom: 30,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          const Positioned(
            right: 12,
            bottom: 12,
            child: Icon(Icons.play_circle_fill,
                color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}
