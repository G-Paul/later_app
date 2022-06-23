import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      title: 'Later App',
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
            fontFamily: 'OpenSans',
            fontSize: 20,
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
  final List<Block> _userLinks = [
    // Block(
    //   id: 'l1',
    //   title: 'Google',
    //   url: 'https://www.google.co.in/',
    //   date: DateTime.now(),
    // ),
    // Block(
    //   id: 'l2',
    //   title: 'YouTube video',
    //   url: 'https://youtu.be/tqsy9Wtr1qE',
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewLink(String title, String url) {
    final newLink = Block(
      id: '${DateTime.now()}_${title}',
      title: title,
      url: url,
      date: DateTime.now(),
    );
    setState(() {
      _userLinks.add(newLink);
      _userLinks.sort((a, b) => b.id.compareTo(a.id));
    });
  }

  void _startAddingNewLink(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewLink(_addNewLink);
        });
  }

  void _deleteLink(String id) {
    setState(() {
      _userLinks.removeWhere((element) => element.id == id);
    });
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
      body: Column(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddingNewLink(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
