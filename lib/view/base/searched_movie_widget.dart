
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/data/model/movie_model.dart';
import 'package:tentwenty_movie_app/util/app_constants.dart';
import 'package:tentwenty_movie_app/util/styles.dart';
import 'package:tentwenty_movie_app/view/screens/upcoming_movie_detail_screen.dart';

class SearchedMovie extends StatelessWidget {
  final Movie? movie;
  const SearchedMovie({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ListTile(
        onTap: () {
          Get.to(() =>  UpComingMovieDetailScreen(movieID: movie!.id,));
        },
        leading: Container(
          height: 200,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500${movie!.posterPath}"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            movie!.title!,
            style: poppinsMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          movie!.releaseDate!, // Catergory was not available in the model
          style: poppinsMedium.copyWith(
            fontSize: 12,
            color: AppConstants.subTitleTextColor,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
