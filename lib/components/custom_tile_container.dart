import 'package:flutter/material.dart';

class CustomTileContainer extends StatelessWidget {
  static BorderRadius customBorderOne = const BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(4),
    bottomLeft: Radius.circular(4),
    bottomRight: Radius.circular(30),
  );

  static BorderRadius customBorderTwo = const BorderRadius.only(
    topLeft: Radius.circular(4),
    topRight: Radius.circular(30),
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(4),
  );

  final BorderRadius customBorder;
  final BorderRadius customBorderAlt;
  final BuildContext context;
  final int index;
  final Widget child;

  const CustomTileContainer({
    super.key,
    required this.customBorder,
    required this.customBorderAlt,
    required this.context,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: (index % 2 == 0) ? customBorder : customBorderAlt,
          color: Theme.of(context).colorScheme.surface, // white
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: (index % 2 == 0) ? customBorder : customBorderAlt,
          ),
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.primary,
            borderRadius: (index % 2 == 0) ? customBorder : customBorderAlt,
            onTap: () {/*for effects only*/},
            child: child,
          ),
        ),
      ),
    );
  }
}
