
import 'package:flutter/material.dart';

class ItemCastWidget extends StatelessWidget {
  const ItemCastWidget({Key? key}) : super(key: key);

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
            backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            "Daniel Gonzales",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
            ),
          ),
          Text(
            "Actor de reparto",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
