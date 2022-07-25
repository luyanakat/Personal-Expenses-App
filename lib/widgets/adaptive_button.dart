import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  const AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            // color: Colors.teal, (more like IOS Style)
            child: Text(text),
            onPressed: () => handler(),
          )
        : TextButton(
            child: Text(text),
            onPressed: () => handler(),
          );
  }
}
