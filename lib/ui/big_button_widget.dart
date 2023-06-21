import 'package:flutter/material.dart';
import 'package:journal_app_v1/ui/palette.dart';

class BigButtonWidget extends StatelessWidget {
  const BigButtonWidget({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.checkboxValue,
    this.counter,
    super.key,
  });
  static const double buttonPadding = 16;
  final IconData icon;
  final String title;
  final Function() onPressed;
  final bool? checkboxValue;
  final int? counter;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: const Size(384, 160)),
          onPressed: onPressed,
          child: Row(
            children: [
              const SizedBox(height: buttonPadding * 2),
              Icon(icon, size: 96),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: buttonPadding,
                    horizontal: buttonPadding,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                  ),
                ),
              ),
              if (checkboxValue != null && counter != null)
                Padding(
                  padding: const EdgeInsets.only(right: buttonPadding - 8, top: buttonPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (checkboxValue != null)
                        IgnorePointer(
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 1),
                            scale: 2,
                            child: Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.white),
                              checkColor: Pal.defaultGreen,
                              value: checkboxValue,
                              onChanged: null,
                            ),
                          ),
                        ),
                      if (counter != null) ...[const SizedBox(height: 8), Text('$counter шт.')],
                    ],
                  ),
                )
            ],
          ),
        ),
      );
}
