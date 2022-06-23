import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/block.dart';

class BlockCard extends StatelessWidget {
  final Block _recBlock;
  final Function _deleteBlock;

  BlockCard(this._recBlock, this._deleteBlock);

  void _launchUrl(Uri url, BuildContext context) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 6,
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.public_outlined,
              color: Theme.of(context).primaryColor),
          iconSize: 40,
          onPressed: () => _launchUrl(Uri.parse(_recBlock.url), context),
        ),
        title: Text(
          _recBlock.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: FittedBox(
              child: Text(
                  _recBlock.url.length > 30
                      ? '${_recBlock.url.substring(0, 30)}...'
                      : _recBlock.url,
                  style: Theme.of(context).textTheme.titleMedium)),
        ),
        trailing: IconButton(
          icon:
              Icon(Icons.delete_outlined, color: Theme.of(context).errorColor),
          onPressed: () => _deleteBlock(_recBlock.id),
        ),
      ),
    );
  }
}
