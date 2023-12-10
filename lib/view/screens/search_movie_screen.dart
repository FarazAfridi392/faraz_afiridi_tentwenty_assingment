import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/controllers/upcoming_movies.controller.dart';
import 'package:tentwenty_movie_app/util/app_constants.dart';
import 'package:tentwenty_movie_app/util/styles.dart';
import 'package:tentwenty_movie_app/view/base/searched_movie_widget.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({
    super.key,
  });
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  bool isSubmitted = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      Get.find<UpComingMoviesController>()
          .searchUpComingMovies(movieName: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: isSubmitted ? 30 : 0,
        toolbarHeight: 80,
        shadowColor: Colors.transparent.withOpacity(0.1),
        elevation: 0,
        centerTitle: false,
        leading: isSubmitted
            ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: poppinsMedium.color,
                  ),
                  onPressed: () => Get.back(),
                ),
              )
            : const SizedBox(),
        title: isSubmitted
            ? Text(
                "${Get.find<UpComingMoviesController>().searchMovideModel!.results!.length.toString()} Results Found",
                style: poppinsMedium,
              )
            : Container(
                alignment: Alignment.center,
                height: 50,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(50)),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: 'TV shows, movies and more',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppConstants.mainTextColor,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: AppConstants.mainTextColor,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          Get.find<UpComingMoviesController>()
                              .getUpComingMovies();
                        },
                      ),
                      alignLabelWithHint: true,
                      border: InputBorder.none),
                  onSubmitted: (value) {
                    setState(() {
                      isSubmitted = true;
                    });
                  },
                ),
              ),
      ),
      body: GetBuilder<UpComingMoviesController>(
          builder: (upcomingMoviesController) {
        return upcomingMoviesController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : upcomingMoviesController.searchMovideModel == null
                ? const Center(
                    child: Text(
                      'Search a Movie',
                      style: poppinsMedium,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isSubmitted
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 10),
                              child: Text(
                                'Top Results',
                                style: poppinsMedium,
                              ),
                            ),
                      isSubmitted
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Divider(),
                            ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SearchedMovie(
                              movie: upcomingMoviesController
                                  .searchMovideModel!.results![index],
                            );
                          },
                          itemCount: upcomingMoviesController
                              .searchMovideModel!.results!.length,
                        ),
                      ),
                    ],
                  );
      }),
    );
  }
}
