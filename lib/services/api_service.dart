import 'dart:convert';
import 'package:flutter_codigo_movieapp/models/movie_detail_model.dart';
import 'package:flutter_codigo_movieapp/models/movie_model.dart';
import 'package:flutter_codigo_movieapp/models/movie_review_model.dart';
import 'package:flutter_codigo_movieapp/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/movie_backdrops_model.dart';
import '../models/movie_cast_model.dart';

class APIService {
  Future<List<MovieModel>> getMovies() async {
    List<MovieModel> movies = [];
    String _url =
        "$pathProduction/discover/movie?api_key=$apiKey&language=en-US&page=1";
    Uri _uri = Uri.parse(_url);
    http.Response _response = await http.get(_uri);
    if (_response.statusCode == 200) {
      Map<String, dynamic> moviesMap = json.decode(_response.body);
      movies = moviesMap["results"]
          .map<MovieModel>((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    }
    return movies;
  }

  Future<MovieDetailModel?> getMovie(int movieId) async {
    String _url =
        "$pathProduction/movie/$movieId?api_key=$apiKey&language=en-US";
    Uri _uri = Uri.parse(_url);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> movieMap = json.decode(response.body);
      MovieDetailModel movieDetailModel = MovieDetailModel.fromJson(movieMap);
      return movieDetailModel;
    }
    return null;
  }

  Future<List<Cast>> getCastMovie(int movieId) async {
    List<Cast> cast = [];

    String _url =
        "$pathProduction/movie/$movieId/credits?api_key=$apiKey&language=en-US";

    Uri _uri = Uri.parse(_url);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> movieMap = json.decode(response.body);

      cast = movieMap["cast"].map<Cast>((e) => Cast.fromJson(e)).toList();
    }
    return cast;
  }

  Future<List<Backdrop>> getBackdropMovie(int movieId) async {
    List<Backdrop> backdrop = [];

    String _url = "$pathProduction/movie/$movieId/images?api_key=$apiKey";

    Uri _uri = Uri.parse(_url);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> movieMap = json.decode(response.body);

      backdrop = movieMap["backdrops"]
          .map<Backdrop>((e) => Backdrop.fromJson(e))
          .toList();
    }
    return backdrop;
  }

  Future<List<Result>> getReviewMovie(int movieId) async {
    List<Result> result = [];

    String _url = "$pathProduction/movie/$movieId/reviews?api_key=$apiKey";

    Uri _uri = Uri.parse(_url);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> movieMap = json.decode(response.body);

      result =
          movieMap["results"].map<Result>((e) => Result.fromJson(e)).toList();
    }
    return result;
  }
}
