import 'package:flutter/material.dart';

class TitleDetailList extends StatelessWidget {
  const TitleDetailList({
    super.key,
    required this.title,
    required this.detailList,
  });

  final String title;
  final List<String> detailList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 18 * detailList.length.toDouble(),
          child: ListView.builder(
            itemCount: detailList.length,
            itemBuilder: (context, index) {
              return Text(detailList[index]);
            },
          ),
        ),
      ],
    );
  }
}
