import 'package:flutter/material.dart';

import '../../models/movie_review_model.dart';

//ignore: must_be_immutable
class ItemReviewWidget extends StatelessWidget {
  Result result;

  ItemReviewWidget({super.key, required this.result});
  String urlImage(String url) {
    if (!url.contains("https")) {
      url = "https://image.tmdb.org/t/p/w500$url";
    } else {
      url = url.replaceAll("/https", "https");
    }

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white12,
              backgroundImage: NetworkImage(result.authorDetails.avatarPath ==
                      null
                  ? "https://objetivoligar.com/wp-content/uploads/2017/03/blank-profile-picture-973460_1280-580x580.jpg"
                  : urlImage(result.authorDetails.avatarPath!)),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(result.author,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            )),
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
                              result.createdAt.toString().substring(0, 10),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(result.content,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                  ]),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
