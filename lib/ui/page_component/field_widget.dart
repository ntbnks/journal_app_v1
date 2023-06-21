import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/palette.dart';
import 'package:journal_app_v1/ui/values.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget(
    this.title, {
    required this.size,
    super.key,
  });

  final String title;
  final double size;
  @override
  // Widget build(BuildContext context) => Column(
  //       children: [
  //         Row(
  //           children: [
  //             AnimatedSize(
  //               duration: const Duration(milliseconds: Val.drawerAnimDuration),
  //               child: SizedBox(
  //                 width: size - 1,
  //                 child: Center(
  //                   child: Text(
  //                     title,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Container(width: 1, color: Colors.black12),
  //           ],
  //         ),
  //         Container(width: size, height: 1, color: Colors.black12),
  //       ],
  //     );

  Widget build(BuildContext context) => AnimatedSize(
        duration: const Duration(milliseconds: Val.drawerAnimDuration),
        child: SizedBox(
          width: size - 1,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

class Separator extends StatelessWidget {
  const Separator({this.color = Pal.defaultGreen, super.key});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: color);
  }
}
