import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias_app/src/models/category_model.dart';
import 'package:noticias_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _ApyKey = '33372907ceba4aadbc7704247d91eb28';

class NewsService with ChangeNotifier {
  List<Article> encabezados = [];

  String _selectedCategory = 'business';

  bool _elLoading = true;

  List<Category> categorias = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopEncabezados();
    categorias.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
    this.getArticulosByCategory(this._selectedCategory);
  }

  bool get elLoading => this._elLoading;

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this._elLoading = true;
    this.getArticulosByCategory(valor);
    notifyListeners();
  }

  get getArticulosCategoriaSelecc =>
      this.categoryArticles[this.selectedCategory];

  getTopEncabezados() async {
    //print('cargando headlines');
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_ApyKey&country=co');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.encabezados.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticulosByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      this._elLoading = false;
      return this.categoryArticles[category];
    }
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_ApyKey&country=co&category=$category');
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    this._elLoading = false;
    notifyListeners();
  }
}
