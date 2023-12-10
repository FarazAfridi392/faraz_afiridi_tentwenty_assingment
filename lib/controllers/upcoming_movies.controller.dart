import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tentwenty_movie_app/data/model/movie_details_model.dart';
import 'package:tentwenty_movie_app/util/app_constants.dart';
import 'package:tentwenty_movie_app/util/the_moviedb_api.dart';
import 'package:tentwenty_movie_app/view/base/custom_snackbar.dart';

import '../data/model/movie_model.dart';

class UpComingMoviesController extends GetxController implements GetxService {
  MovieModel? _movieModel;
  MovieModel? _searchMovieModel;
  MovieDetailsModel? _movieDetailsModel;
  bool _isLoading = false;

  MovieModel? get movieModel => _movieModel;
  MovieModel? get searchMovideModel => _searchMovieModel;
  MovieDetailsModel? get movieDetailsModel => _movieDetailsModel;

  bool get isLoading => _isLoading;

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $themoviedbApi'
  };

  Future getUpComingMovies() async {
    try {
      _searchMovieModel = null;
      _isLoading = true;
      update();

      var request = await http.get(
        Uri.parse(AppConstants.upcomingMoviesUrl),
        headers: headers,
      );

      if (request.statusCode == 200) {
        print(request.body);

        _movieModel = MovieModel.fromJson(jsonDecode(request.body));
        _isLoading = false;
        update();
      } else {
        print(request.body);
        _isLoading = false;
        showCustomSnackBar('StatusCode Error', isError: true);
      }
    } catch (e) {
      _isLoading = false;
      showCustomSnackBar('Error: $e', isError: true);
    }
  }

  Future searchUpComingMovies({
    required String movieName,
  }) async {
    try {
      _isLoading = true;
      update();

      var request = await http.get(
        Uri.parse(
            "${AppConstants.searchMovieUrl}&language=en-US&page=1&include_adult=false&query=$movieName"),
        headers: headers,
      );

      print(
        Uri.parse(
            "${AppConstants.searchMovieUrl}&language=en-US&page=1&include_adult=false&query=$movieName"),
      );

      if (request.statusCode == 200) {
        _searchMovieModel = MovieModel();

        _searchMovieModel = MovieModel.fromJson(jsonDecode(request.body));
        _isLoading = false;
        update();
      } else {
        print(request.body);
        _isLoading = false;
        showCustomSnackBar('StatusCode Error', isError: true);
      }
    } catch (e) {
      _isLoading = false;
      showCustomSnackBar('Error: $e', isError: true);
    }
  }

  Future getMovieDetails({
    required int movieId,
  }) async {
    try {
      _isLoading = true;

      var request = await http.get(
        Uri.parse(
            "${AppConstants.movieDetailsUrl}$movieId?api_key=$themoviedbApi"),
        headers: headers,
      );

      print(request.body);

      if (request.statusCode == 200) {
        print(request.body);
        _movieDetailsModel =
            MovieDetailsModel.fromJson(jsonDecode(request.body));
        _isLoading = false;
        update();
      } else {
        print(request.body);
        _isLoading = false;
        showCustomSnackBar('StatusCode Error', isError: true);
      }
    } catch (e) {
      _isLoading = false;
      showCustomSnackBar('Error: $e', isError: true);
    }
  }
}
