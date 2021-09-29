import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  final String source =
      "http://api.themoviedb.org/3/movie/popular?api_key=275f63c86870939aaaea0686b97e8b31";

  Future<ItemModel> fetchMovieList() async {
    print('entered');
    final response = await client.get(Uri.parse(source));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load post');
    }
  }
}
