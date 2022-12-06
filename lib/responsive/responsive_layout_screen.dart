import 'package:flutter/material.dart';

import '../utils/dementions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobilescreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobilescreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth > webScreenSize) {
          return webScreenLayout;
        }
        return mobilescreenLayout;
      },
    );
  }
}
