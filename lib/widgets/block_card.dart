import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:clipboard/clipboard.dart';
import '../models/block.dart';

class BlockCard extends StatelessWidget {
  final Block _recBlock;
  final Function _deleteBlock;

  BlockCard(this._recBlock, this._deleteBlock);

  void _launchUrl(Uri url, BuildContext context) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            // Name part
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _launchUrl(Uri.parse(_recBlock.url), context),
                    onLongPress: () {
                      FlutterClipboard.copy(_recBlock.url).then((result) {
                        final snackBar = SnackBar(
                          content: Text('Copied to Clipboard'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // flex: 1,
                          // width: 200,
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Text(
                              _recBlock.title,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        Container(
                          // flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              '${DateFormat('dd-MM-yyyy').format(_recBlock.date)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Color.fromARGB(143, 124, 124, 124),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(10),
                  icon: Icon(Icons.more_vert_rounded),
                  onPressed: () => _deleteBlock(_recBlock.id),
                ),
              ],
            ),
            Divider(
              color: Color.fromARGB(108, 106, 106, 106),
              endIndent: 10,
              indent: 10,
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 5),
                  child: Image.network(
                    "https://www.google.com/s2/favicons?domain_url=${_recBlock.url}",
                    height: 16,
                    width: 16,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Icon(
                        Icons.public,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                ),
                // Container(
                //   height: 20,
                //   width: 20,
                //   color: Colors.grey,
                // ),
                SizedBox(
                  height: 16,
                  width: 3,
                  child: VerticalDivider(
                    endIndent: 2,
                    color: Color.fromARGB(108, 106, 106, 106),
                  ),
                ),
                Expanded(
                  // width: MediaQuery.of(context).size.width - 90,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      _recBlock.url,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Color.fromARGB(159, 78, 78, 78)),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                  width: 3,
                  child: VerticalDivider(
                    endIndent: 2,
                    color: Color.fromARGB(108, 106, 106, 106),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
              ],
            ),

            // Link part
          ],
        ),
      ),
    );
  }
}

// Previous block card widget: 


  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //     elevation: 6,
  //     child: ListTile(
  //       // leading: IconButton(
  //       //   icon: ImageIcon(NetworkImage(
  //       //     "https://www.google.com/s2/favicons?domain_url=${_recBlock.url}",
  //       //   )),
  //       //   iconSize: 40,
  //       //   onPressed: () => _launchUrl(Uri.parse(_recBlock.url), context),
  //       // ),
  //       leading: InkWell(
  //         onTap: () => _launchUrl(Uri.parse(_recBlock.url), context),
  //         child: Image.network(
  //           "https://www.google.com/s2/favicons?domain_url=${_recBlock.url}",
  //           height: 60,
  //           width: 40,
  //           scale: 0.6,
  //           errorBuilder: (context, error, stackTrace) {
  //             return const Icon(Icons.public_outlined);
  //           },
  //         ),
  //       ),
  //       title: Text(
  //         _recBlock.title,
  //         style: Theme.of(context).textTheme.titleLarge,
  //       ),
  //       subtitle: Container(
  //         height: 20,
  //         alignment: Alignment.centerLeft,
  //         child: FittedBox(
  //             child: Text(
  //                 _recBlock.url.length > 30
  //                     ? '${_recBlock.url.substring(0, 30)}...'
  //                     : _recBlock.url,
  //                 style: Theme.of(context).textTheme.titleMedium)),
  //       ),
  //       trailing: IconButton(
  //         icon:
  //             Icon(Icons.delete_outlined, color: Theme.of(context).errorColor),
  //         onPressed: () => _deleteBlock(_recBlock.id),
  //       ),
  //     ),
  //   );
  // }
