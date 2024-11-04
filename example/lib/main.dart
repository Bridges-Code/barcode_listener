import 'package:barcode_listener/barcode_listener.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final keyFocus = FocusNode();
  final textFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BarcodeListener(
        focusNode: keyFocus,
        onBarcodeScanned: (barcode) {
          print(barcode);
        },
        child: Scaffold(
          body: Center(
            child: Focus(
                child: TextField(
              onEditingComplete: () => keyFocus.requestFocus(),
            )),
          ),
        ));
  }
}
