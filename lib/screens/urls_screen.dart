import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/scan_tiles.dart';

class UrlsScreen extends StatelessWidget {
  const UrlsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(type: 'http');
  }
}
