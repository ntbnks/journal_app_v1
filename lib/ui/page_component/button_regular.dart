import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/palette.dart';

class ButtonRegular extends StatefulWidget {
  const ButtonRegular({super.key});

  @override
  State<ButtonRegular> createState() => _ButtonRegularState();
}

class _ButtonRegularState extends State<ButtonRegular> {
  static const List<List<Color>> bakeGradient = [
    [Pal.defaultGreenGradient, Pal.defaultGreen],
    [Pal.defaultGreenHighlight, Pal.defaultGreen]
  ];

  bool hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: hover ? bakeGradient[1] : bakeGradient[0],
            ),
            boxShadow: [
              BoxShadow(
                offset: hover ? const Offset(2, 4) : const Offset(2, 2),
                blurRadius: 5,
                color: hover ? Colors.black38 : Colors.black26,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
            child: Column(
              children: [
                const Icon(Icons.abc, color: Colors.white, size: 64),
                Text(
                  'Big button',
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
}
