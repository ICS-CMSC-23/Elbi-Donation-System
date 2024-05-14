import 'package:flutter/material.dart';

class PageCover extends StatelessWidget {
  const PageCover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: 200,
            child: const Center(
                child: Icon(
              Icons.handshake_rounded,
              size: 100,
            )),
          ),
          const Flexible(
            child: Text(
              "Your Generosity Knows No Bounds",
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
