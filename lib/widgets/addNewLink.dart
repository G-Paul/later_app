import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewLink extends StatefulWidget {
  final Function addLink;
  late String? sharedUrl = "";
  NewLink.noUrl(this.addLink);
  NewLink.withUrl(this.addLink, this.sharedUrl);

  @override
  State<NewLink> createState() => _NewLinkState();
}

class _NewLinkState extends State<NewLink> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String? url = widget.sharedUrl;
    if (url != null) {
      _urlController.text = url;
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredUrl = _urlController.text;
    if (enteredTitle.isEmpty || enteredUrl.isEmpty) {
      return;
    }

    Navigator.of(context).pop();
    widget.addLink(enteredTitle, enteredUrl);
  }

  @override
  Widget build(BuildContext context) {
    bool isLaunchable = false;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'URL'),
                  controller: _urlController,
                  onSubmitted: (_) => _submitData(),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Add Link'),
                ),
              ],
            )),
      ),
    );
  }
}
