import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/controllers/upcoming_movies.controller.dart';

import 'package:tentwenty_movie_app/util/styles.dart';
import 'package:tentwenty_movie_app/view/base/upcoming_movie_widget.dart';
import 'package:tentwenty_movie_app/view/screens/search_movie_screen.dart';

class UpcomingMoviesScreen extends StatefulWidget {
  const UpcomingMoviesScreen({super.key});

  @override
  State<UpcomingMoviesScreen> createState() => _UpcomingMoviesScreenState();
}

class _UpcomingMoviesScreenState extends State<UpcomingMoviesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(UpComingMoviesController());
    Get.find<UpComingMoviesController>().getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Watch',
                style: poppinsMedium,
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => const MovieSearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<UpComingMoviesController>(
            builder: (upcomingMoviesController) {
          return upcomingMoviesController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : upcomingMoviesController.movieModel == null
                        ? const Center(
                          child:  Text(
                              'No Movies Yet!',
                              style: poppinsMedium,
                            ),
                        )
                        : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 /
                        2, // Adjust the ratio for your desired width to height ratio of the container
                  ),
                  itemBuilder: (context, index) {
                    return  UpComingMovie(
                            movie: upcomingMoviesController
                                .movieModel!.results![index]
                            
                          );
                  },
                  itemCount: upcomingMoviesController.movieModel!.results!
                      .length, // Replace with your desired item count
                );
        }));
  }
}
