import 'package:flutter/material.dart';
import 'package:flutter_codigo_movieapp/models/movie_detail_model.dart';
import 'package:flutter_codigo_movieapp/models/movie_review_model.dart';
import 'package:flutter_codigo_movieapp/services/api_service.dart';
import 'package:flutter_codigo_movieapp/ui/general/colors.dart';
import 'package:flutter_codigo_movieapp/ui/widgets/item_cast_widget.dart';
import 'package:flutter_codigo_movieapp/ui/widgets/item_review_widget.dart';
import 'package:flutter_codigo_movieapp/ui/widgets/line_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/movie_backdrops_model.dart';
import '../models/movie_cast_model.dart';

class DetailPage extends StatefulWidget {
  int movieId;
  DetailPage({required this.movieId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final APIService _apiService = APIService();
  MovieDetailModel? movieDetailModel;
  List<Cast>? movieCastModel;
  List<Backdrop>? movieBackdropModel;
  List<Result>? movieReviewModel;

  bool isLoading = true;
  bool getDataMovie = false;
  bool getDataCast = false;
  bool getDataReview = false;
  bool getDataBackdrop = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  verificarCarga() {
    if (getDataMovie && getDataCast && getDataReview && getDataBackdrop) {
      isLoading = false;
      setState(() {});
    }
  }

  getData() {
    _apiService.getMovie(widget.movieId).then((value) {
      if (value != null) {
        movieDetailModel = value;
        getDataMovie = true;
        verificarCarga();
      }
    });

    _apiService.getBackdropMovie(widget.movieId).then((value) {
      if (value != null) {
        movieBackdropModel = value;
        getDataBackdrop = true;
        verificarCarga();
      }
    });
    _apiService.getCastMovie(widget.movieId).then((value) {
      if (value != null) {
        movieCastModel = value;
        getDataCast = true;
        verificarCarga();
      }
    });

    _apiService.getReviewMovie(widget.movieId).then((value) {
      if (value != null) {
        movieReviewModel = value;
        getDataReview = true;
        verificarCarga();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: !isLoading
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    movieDetailModel!.originalTitle,
                  ),
                  centerTitle: true,
                  backgroundColor: kBrandPrimaryColor,
                  expandedHeight: 220.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          "https://image.tmdb.org/t/p/w500${movieDetailModel!.backdropPath}",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kBrandPrimaryColor,
                                kBrandPrimaryColor.withOpacity(0.01),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: false,
                  snap: false,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movieDetailModel!.posterPath}",
                                    height: 160.0,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.date_range,
                                            color: Colors.white70,
                                            size: 14.0,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            movieDetailModel!.releaseDate
                                                .toString()
                                                .substring(0, 10),
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        movieDetailModel!.originalTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6.0,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.timelapse,
                                            color: Colors.white70,
                                            size: 14.0,
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            "${movieDetailModel!.runtime} min.",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Overview",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            LineWidget(
                              width: 50,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              movieDetailModel!.overview,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 54.0,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  Uri _uri =
                                      Uri.parse(movieDetailModel!.homepage);
                                  await launchUrl(_uri);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: kBrandSecondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.link,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Home page",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const Text(
                              "Genres",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            LineWidget(
                              width: 50,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              alignment: WrapAlignment.start,
                              spacing: 8.0,
                              children: movieDetailModel!.genres
                                  .map(
                                    (e) => Chip(
                                      label: Text(
                                        e.name,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Cast",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            LineWidget(
                              width: 50,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    alignment: WrapAlignment.start,
                                    spacing: 8.0,
                                    children: movieCastModel!
                                        .map(
                                          (e) => ItemCastWidget(
                                              character: e.character,
                                              knownForDepartment:
                                                  e.knownForDepartment,
                                              name: e.name,
                                              profilePath: e.profilePath),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Backdrop",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            LineWidget(
                              width: 50,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    alignment: WrapAlignment.start,
                                    spacing: 8.0,
                                    children: movieBackdropModel!
                                        .map(
                                          (e) => Image.network(
                                            "https://image.tmdb.org/t/p/w500${e.filePath}",
                                            height: 160.0,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Review",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            LineWidget(
                              width: 50,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Column(children: [
                              ...movieReviewModel!
                                  .map(
                                    (e) => ItemReviewWidget(result: e),
                                  )
                                  .toList(),
                            ]),
                            SizedBox(
                              height: 70.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
