import 'package:data_saving/home.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocumentDir.path);
  await Hive.openBox('notifications');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TheData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hive",
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromRGBO(0, 133, 119, 1)),
    );
  }
}
