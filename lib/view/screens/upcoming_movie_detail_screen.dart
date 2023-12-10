import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tentwenty_movie_app/controllers/upcoming_movies.controller.dart';
import 'package:tentwenty_movie_app/theme/light_theme.dart';
import 'package:tentwenty_movie_app/util/styles.dart';
import 'package:http/http.dart' as http;
import 'package:tentwenty_movie_app/util/the_moviedb_api.dart';
import 'package:tentwenty_movie_app/view/screens/seat_mapping_screen.dart';
import 'package:tentwenty_movie_app/view/screens/video_player_screen.dart';

class UpComingMovieDetailScreen extends StatefulWidget {
  final int? movieID;
  const UpComingMovieDetailScreen({super.key, this.movieID});

  @override
  State<UpComingMovieDetailScreen> createState() =>
      _UpComingMovieDetailScreenState();
}

class _UpComingMovieDetailScreenState extends State<UpComingMovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<UpComingMoviesController>()
        .getMovieDetails(movieId: widget.movieID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<UpComingMoviesController>(
      builder: (controller) {
        DateTime? parsedDate;
        if (controller.movieDetailsModel != null) {
          parsedDate =
              DateTime.parse(controller.movieDetailsModel!.releaseDate!);
        }
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${controller.movieDetailsModel!.posterPath}"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 50,
                            left: 15,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                Text(
                                  'Watch',
                                  style: poppinsMedium.copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  controller.movieDetailsModel!.title!,
                                  style: poppinsMedium.copyWith(
                                      color: Colors.yellow, fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'In theaters ${DateFormat('MMMM dd, yyyy').format(parsedDate!)}',
                                  style: poppinsMedium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.to(() => MovieSeatSelectionScreen());
                                    },
                                    child: SizedBox(
                                      height: 70,
                                      width: 300,
                                      child: Center(
                                        child: Text(
                                          "Get Tickets",
                                          style: poppinsMedium.copyWith(
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side:
                                                  BorderSide(color: primary)))),
                                  onPressed: () => _playTrailer(controller
                                      .movieDetailsModel!.id
                                      .toString()),
                                  child: SizedBox(
                                    height: 70,
                                    width: 300,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.play_arrow),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Watch Trailer",
                                          style: poppinsMedium.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Genres",
                            style: poppinsMedium,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  controller.movieDetailsModel!.genres!.length,
                              itemBuilder: (context, index) {
                                Color randomColor = Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)]
                                    .withOpacity(1);

                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                      left: index == 0 ? 0 : 10,
                                      right: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: randomColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      controller.movieDetailsModel!
                                          .genres![index].name!,
                                      style: poppinsSemiBold.copyWith(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, right: 30),
                              child: Divider(
                                thickness: 1,
                              )),
                          const Text(
                            "Overview",
                            style: poppinsMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.movieDetailsModel!.overview!,
                            style: poppinsMedium.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF8F8F8F)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    ));
  }
}

void _playTrailer(String movieId) async {
  final url =
      'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$themoviedbApi';
  final response = await http.get(Uri.parse(url));
  final data = json.decode(response.body);
  print(url);
  print(data);

  final trailerUrl = data['results'][0]['key'];
  print(trailerUrl);

  Get.to(
    () => YouTubeVideoPlayerScreen(videoId: trailerUrl),
  );
}
