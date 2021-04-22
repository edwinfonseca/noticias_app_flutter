import 'package:flutter/material.dart';
import 'package:noticias_app/src/pages/tabs_page.dart';
import 'package:noticias_app/src/theme/tema.dart';
import 'package:provider/provider.dart';
import 'package:noticias_app/src/services/news_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
        //para utilizar multiples instancias de providers que se necesiten
      ],
      child: MaterialApp(
        theme: miTema,
        debugShowCheckedModeBanner: false,
        title: 'app noticias',
        home: TabsPage(),
      ),
    );
  }
}
