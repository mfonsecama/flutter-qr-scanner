import 'package:flutter/material.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> insertScan(String valor) async {
    final scan = ScanModel(value: valor);
    final id = await DBProvider.db.insertScan(scan);
    scan.id = id;
    if (selectedType == scan.type) {
      scans.add(scan);
      notifyListeners();
    }
    return scan;
  }

  loadScans() async {
    final res = await DBProvider.db.findAllScan();
    scans = [...res];
    notifyListeners();
  }

  loadScansByType(String type) async {
    scans = [];
    final res = await DBProvider.db.findScanByType(type);
    scans = [...res];
    selectedType = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    loadScansByType(selectedType);
  }
}
