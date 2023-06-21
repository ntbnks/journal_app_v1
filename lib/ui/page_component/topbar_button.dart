import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/palette.dart';

class TopBarButton extends StatelessWidget {
  const TopBarButton({
    required this.onPressed,
    required this.icon,
    this.loadingFlag = false,
    this.color = PaletteColor.green,
    this.tooltip = '',
    super.key,
  });

  final Function() onPressed;
  final IconData icon;
  final PaletteColor color;
  final bool loadingFlag;
  final String tooltip;
  List<Color> get pal => loadingFlag
      ? [Pal.defaultDisabledGradient, Pal.defaultDisabled]
      : color == PaletteColor.red
          ? [Pal.defaultRedGradient, Pal.defaultRed]
          : [Pal.defaultGreenGradient, Pal.defaultGreen];

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: pal,
          ),
        ),
        child: Tooltip(
          message: tooltip,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: const Size(48, 48),
              shape: const CircleBorder(),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: loadingFlag ? null : onPressed,
            child: loadingFlag
                ? const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Icon(icon, color: Colors.white),
          ),
        ),
      );
}
