import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/scan_tiles.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(type: 'geo');
  }
}
