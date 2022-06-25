import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:later_app/models/database_helper.dart';

import './models/block.dart';
import './widgets/block_list.dart';
import './widgets/addNewLink.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LATER APP',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Color.fromARGB(255, 255, 196, 0),
        // accentColor: Color.fromARGB(255, 183, 0, 255),
        errorColor: Color.fromARGB(255, 255, 60, 0),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 17),
          titleMedium: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.normal,
              color: Colors.grey,
              fontSize: 15),
          titleSmall: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ),
        // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),

        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Block> _userLinks;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    DatabaseHelper.instance.closedb();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this._userLinks = await DatabaseHelper.instance.readAllBlock();
    setState(() => isLoading = false);
  }

  Future _addNewLink(String title, String url) async {
    final newLink = Block(
      // id: 1, /////////////////////////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      title: title,
      url: url,
      date: DateTime.now(),
    );
    // setState(() {
    //   _userLinks.add(newLink);
    //   _userLinks.sort((a, b) => a.date.compareTo(a.date));
    // });
    setState(() => isLoading = true);
    await DatabaseHelper.instance.insertBlock(newLink);
    await refreshNotes();
    setState(() => isLoading = false);
  }

  void _startAddingNewLink(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewLink(_addNewLink);
        });
  }

  Future _deleteLink(int id) async {
    // setState(() {
    //   _userLinks.removeWhere((element) => element.id == id);
    // });
    setState(() => isLoading = true);
    await DatabaseHelper.instance.deleteBlock(id);
    refreshNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Later App'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddingNewLink(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top),
                      child: BlockList(_userLinks, _deleteLink),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddingNewLink(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
