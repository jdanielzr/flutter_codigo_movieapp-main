import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemCastWidget extends StatelessWidget {
  String name;
  String character;
  String knownForDepartment;
  String? profilePath;

  ItemCastWidget(
      {super.key,
      required this.name,
      required this.character,
      required this.knownForDepartment,
      this.profilePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white12,
            backgroundImage: NetworkImage(profilePath == null
                ? "https://objetivoligar.com/wp-content/uploads/2017/03/blank-profile-picture-973460_1280-580x580.jpg"
                : "https://image.tmdb.org/t/p/w500$profilePath"),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
          Text(
            knownForDepartment,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
