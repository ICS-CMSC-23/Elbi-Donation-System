import 'package:elbi_donation_system/components/upload_helper.dart';
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
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.memory(
          decodeBase64Image(source),
          width: size,
          height: size,
          errorBuilder: (context, error, stackTrace) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: Image.asset('assets/images/portrait-placeholder.jpg',
                  width: size, height: size, fit: BoxFit.cover),
            );
          },
          fit: BoxFit.cover,
        );
      },
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: imageType,
    );
  }
}
