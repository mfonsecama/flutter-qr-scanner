import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/utils/utils.dart';

import '../providers/scan_list_provider.dart';

class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanListProvider>(context);
    final scans = scanProvider.scans;

    return ListView.builder(
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.redAccent,
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScanById(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(
            type == 'geo' ? Icons.map : Icons.home,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[index].value),
          subtitle: Text('ID: ${scans[index].id}'),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () {
            launchUrl(context, scans[index]);
          },
        ),
      ),
      itemCount: scans.length,
    );
  }
}
