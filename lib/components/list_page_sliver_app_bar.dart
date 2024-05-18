import 'package:flutter/material.dart';

class ListPageSliverAppBar extends StatelessWidget {
  final String title;
  final Widget backgroundWidget;
  const ListPageSliverAppBar({
    super.key,
    required this.title,
    required this.backgroundWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      pinned: true,
      centerTitle: false,
      expandedHeight: 200,
      stretch: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 10),
              opacity: top <= kToolbarHeight + 50 ? 1.0 : 0.0,
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
            centerTitle: false,
            background: backgroundWidget,
          );
        },
      ),
    );
  }
}
