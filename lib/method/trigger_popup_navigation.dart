import 'dart:async';

import 'package:flutter/material.dart';

void triggerPopupNavigation(BuildContext context, Function() onPressed) {
  Navigator.of(context).pop();
  Timer(
    const Duration(milliseconds: 100),
    onPressed,
  );
}
