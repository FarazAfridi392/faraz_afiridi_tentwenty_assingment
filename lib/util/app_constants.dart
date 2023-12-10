

import 'package:flutter/material.dart';
import 'package:tentwenty_movie_app/util/the_moviedb_api.dart';

class AppConstants{

// Urls
static const String upcomingMoviesUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$themoviedbApi';
static const String searchMovieUrl = 'https://api.themoviedb.org/3/search/movie?api_key=$themoviedbApi';
static const String movieDetailsUrl = 'https://api.themoviedb.org/3/movie/';

// Colors

static const Color mainTextColor = Color(0xFF202C43);
static const Color subTitleTextColor = Color(0xFFDBDBDF);

}
