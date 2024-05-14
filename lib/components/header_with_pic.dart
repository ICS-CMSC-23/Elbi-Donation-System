import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWithPic extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  const HeaderWithPic({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedImage(
            source: imageUrl ?? "/assets/images/portrait-placeholder.jpg",
            size: 80),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  description ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
