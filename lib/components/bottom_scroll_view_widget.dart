import 'package:flutter/material.dart';

class BottomScrollViewWidget extends StatelessWidget {
  final String listTitle;
  final int listLength;

  const BottomScrollViewWidget({
    super.key,
    required this.listTitle,
    required this.listLength,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Center(
              child: Text(
                "$listTitle: $listLength",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
