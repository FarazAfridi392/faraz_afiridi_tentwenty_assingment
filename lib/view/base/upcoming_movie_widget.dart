
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/data/model/movie_model.dart';
import 'package:tentwenty_movie_app/util/styles.dart';
import 'package:tentwenty_movie_app/view/screens/upcoming_movie_detail_screen.dart';

class UpComingMovie extends StatelessWidget {
  final Movie? movie;
  const UpComingMovie({
    Key? key,
    this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() =>  UpComingMovieDetailScreen(movieID: movie!.id));
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), 
          image: DecorationImage(
            image: NetworkImage("https://image.tmdb.org/t/p/w500${movie!.posterPath}"), 
            fit: BoxFit.fill, 
          ),
        ),
        alignment: Alignment.bottomLeft, 
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            movie!.title!, 
            style: poppinsMedium.copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
