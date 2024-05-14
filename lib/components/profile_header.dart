import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedImage(
            source:
                user.profilePhoto ?? "/assets/images/portrait-placeholder.jpg",
            size: 80),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.username,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  user.about ?? "",
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
