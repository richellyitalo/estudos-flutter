import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ButtonAdaptative extends StatelessWidget {
  final Function fn;
  final Widget child;

  ButtonAdaptative(this.child, this.fn);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: child,
            onPressed: fn,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20,)
          )
        : ElevatedButton(child: child, onPressed: fn);
  }
}
