library barcode_listener;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef OnBarcodeScanned = void Function(String barcode);

class BarcodeListener extends StatefulWidget {
  const BarcodeListener({
    super.key,
    this.focusNode,
    required this.onBarcodeScanned,
    required this.child,
  });

  final FocusNode? focusNode;
  final OnBarcodeScanned onBarcodeScanned;
  final Widget child;

  @override
  State<BarcodeListener> createState() => _BarcodeListenerState();
}

class _BarcodeListenerState extends State<BarcodeListener> {
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  final StringBuffer _barcode = StringBuffer();

  @override
  Widget build(BuildContext context) {
    return Focus(
        autofocus: true,
        focusNode: _focusNode,
        onKeyEvent: (node, event) {
          if (!node.hasPrimaryFocus) return KeyEventResult.ignored;

          if (event.logicalKey.keyLabel == 'Enter' &&
              _barcode.isNotEmpty &&
              event is KeyDownEvent) {
            widget.onBarcodeScanned(_barcode.toString());
            _barcode.clear();
            return KeyEventResult.handled;
          }

          if (event.character != null &&
              RegExp(r'^[a-zA-Z0-9\-_\@\#]$').hasMatch(event.character!)) {
            _barcode.write(event.character);
          }

          return KeyEventResult.handled;
        },

        /// This GestureDetector is used to request focus when the user taps on
        /// the widget.
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _focusNode.requestFocus(),
          child: widget.child,
        ));
  }
}
