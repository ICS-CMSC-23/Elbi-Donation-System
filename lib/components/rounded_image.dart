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
        try {
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
        } catch (e) {
          return Image.asset('assets/images/portrait-placeholder.jpg',
              width: size, height: size, fit: BoxFit.cover);
        }
      },
    );

    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: imageType,
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      source,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        try {
                          return Image.memory(
                            decodeBase64Image(source),
                            errorBuilder: (context, error, stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(size / 2),
                                child: Image.asset(
                                    'assets/images/portrait-placeholder.jpg',
                                    fit: BoxFit.cover),
                              );
                            },
                            fit: BoxFit.cover,
                          );
                        } catch (e) {
                          try {
                            return Image.memory(
                              decodeBase64ImageUncompressed(source),
                              errorBuilder: (context, error, stackTrace) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(size / 2),
                                  child: Image.asset(
                                      'assets/images/portrait-placeholder.jpg',
                                      fit: BoxFit.cover),
                                );
                              },
                              fit: BoxFit.cover,
                            );
                          } catch (e) {
                            return Image.asset(
                                'assets/images/portrait-placeholder.jpg',
                                fit: BoxFit.cover);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Exit'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
