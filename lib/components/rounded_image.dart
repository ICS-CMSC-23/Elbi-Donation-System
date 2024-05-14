import 'package:flutter/material.dart';

//widget for rounded images
class RoundedImage extends StatelessWidget {
  final String source;
  final double size;
  const RoundedImage({super.key, required this.source, required this.size});

  @override
  Widget build(BuildContext context) {
    Image imageType = source[0] == "/"
        ? Image.asset(
            source,
            width: size,
            height: size,
            fit: BoxFit.cover,
          )
        : Image.network(
            source,
            width: size,
            height: size,
            fit: BoxFit.cover,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Expanded(child: imageType),
    );
  }
}
