import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //    '#3D8bef', 'Cancelar', false, ScanMode.QR);
        //final barcodeScanRes = 'https://www.google.es';
        final barcodeScanRes = 'geo:40.318752,-3.700963';
        if (barcodeScanRes == '-1') {
          return;
        }
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final scan = await scanListProvider.insertScan(barcodeScanRes);
        launchUrl(context, scan);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
