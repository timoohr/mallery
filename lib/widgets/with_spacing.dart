import 'package:flutter/material.dart';

extension WithSpacing on List<Widget> {
  List<Widget> withSpacing({double? width, double? height}) {
    final list = expand((element) => [element, SizedBox(width: width, height: height)]).toList();
    return list.take(list.length-1).toList();
  }
}