import 'package:flutter/material.dart';

class ListPageHeader extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  const ListPageHeader({
    super.key,
    required this.title,
    required this.titleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Column(
        children: [
          const SizedBox(height: 75),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: 125,
                child: Center(
                    child: Icon(
                  titleIcon,
                  size: 100,
                )),
              ),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 30),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
