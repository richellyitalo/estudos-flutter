import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;

  Badge({this.child, this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        child,
        Positioned(
          top: 8,
          right: 5,
          child: Container(
            width: 15,
            height: 15,
            constraints: BoxConstraints(
              maxHeight: 16,
              minWidth: 16,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(50)),
            child: Text(value, style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
