import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/palette.dart';

class ButtonSized extends StatelessWidget {
  const ButtonSized({
    super.key,
    required this.title,
    required this.loading,
    this.disabled,
    this.width,
    this.height = 48,
    this.scale = 1,
    this.icon,
    required this.onPressed,
    this.colorBackgroundDisabled,
    this.showLoadingIndicator,
  });

  final String title;
  final bool loading;
  final bool? disabled;
  final double? width;
  final double height;
  final double scale;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? colorBackgroundDisabled;
  final bool? showLoadingIndicator;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: (disabled ?? false) || loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor:
                  colorBackgroundDisabled ?? Pal.defaultDisabled.withAlpha(128),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: (showLoadingIndicator ?? true) && loading ? 1 : 0,
                  child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
                Opacity(
                  opacity: loading ? 0 : 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: 24 * scale,
                          color: (disabled ?? false) || loading ? Colors.white70 : Colors.white,
                        ),
                        SizedBox(width: 8 * (scale * 1.5)),
                      ],
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: (disabled ?? false) || loading ? Colors.white70 : Colors.white,
                              letterSpacing: 0,
                              fontSize: 19.5 * scale,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class TextButtonSized extends StatelessWidget {
  const TextButtonSized({
    super.key,
    required this.title,
    required this.loading,
    this.width,
    this.height = 48,
    this.scale = 1,
    this.icon,
    required this.onPressed,
  });

  final String title;
  final bool loading;
  final double? width;
  final double height;
  final double scale;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: width,
          height: height,
          child: TextButton(
            onPressed: loading ? null : onPressed,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: loading ? 1 : 0,
                  child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: Pal.defaultGreen,
                    ),
                  ),
                ),
                Opacity(
                  opacity: loading ? 0 : 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 24 * scale),
                        SizedBox(width: 8 * (scale * 1.5)),
                      ],
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Pal.defaultGreen,
                              letterSpacing: 0,
                              fontSize: 19.5 * scale,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
