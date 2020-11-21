import 'package:flutter/material.dart';
import 'dart:html' as html;

extension hoverExtensin on Widget {
  static final appContainer = html.window.document.getElementById("container");
  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'defaul',
    );
  }
}
