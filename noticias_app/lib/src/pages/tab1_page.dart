import 'package:flutter/material.dart';
import 'package:noticias_app/src/services/news_service.dart';
import 'package:noticias_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

/*para que mantenga el estado se transforma de un Stateles a un Stateful
* usar AutomaticKeepAliveClientMixin y crear el @override del final
* */
class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final encabezados = Provider.of<NewsService>(context).encabezados;
    //se llama directamente los encavezados
    //final newsService = Provider.of<NewsService>(context);
    //newsService.encabezados;
    return Scaffold(
      body: (encabezados.length == 0)
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : ListaNoticias(encabezados), //se llama directamente los encavezados
      //body: ListaNoticias(newsService.encabezados),
    );
  }

  @override
  // TODO: implement wantKeepAlive se cambia a true
  bool get wantKeepAlive => true;
}
