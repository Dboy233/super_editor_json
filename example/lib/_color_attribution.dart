import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

extension ColorAttributionExt on TextStyle {
  TextStyle mergeColorAttribution(Attribution attribution) {
    if (attribution is ColorAttribution) {
      return copyWith(
        color: attribution.color,
      );
    }
    return this;
  }
}

///自定义属性样式
class ColorAttribution extends Attribution {
  final Color color;

  ColorAttribution(this.color);

  @override
  bool canMergeWith(Attribution other) {
    return this == other;
  }

  @override
  String toString() {
    return '[ColorAttribution]: ${color.value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ColorAttribution && runtimeType == other.runtimeType && color == other.color;

  @override
  int get hashCode => color.hashCode;

  @override
  String get id => 'color';
}
