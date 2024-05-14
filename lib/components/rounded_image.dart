import 'package:flutter/material.dart';

//widget for rounded images
class RoundedImage extends StatelessWidget {
  final String source;
  final double size;
  const RoundedImage({super.key, required this.source, required this.size});

  @override
  Widget build(BuildContext context) {
    Image imageType = Image.network(
      source,
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/portrait-placeholder.jpg',
            fit: BoxFit.fitWidth);
      },
      fit: BoxFit.cover,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Column(
        children: [
          Expanded(child: imageType),
        ],
      ),
    );
  }
}
