import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_codigo_movieapp/models/movie_model.dart';
import 'package:flutter_codigo_movieapp/services/api_service.dart';
import 'package:flutter_codigo_movieapp/ui/general/colors.dart';
import 'package:flutter_codigo_movieapp/ui/widgets/item_movie_widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<MovieModel> movies = [];


  @override
  initState(){
    super.initState();
    getData();
  }

  getData(){
    APIService _apiService = APIService();
    _apiService.getMovies().then((value){
      movies = value;
      setState((){});
    });
  }

  // getMovies() async{
  //   String _url = "https://api.themoviedb.org/3/discover/movie?api_key=b7f401f74af26d78db0040978dd2420c&language=en-US&page=1";
  //   Uri _uri = Uri.parse(_url);
  //   http.Response _response = await http.get(_uri);
  //   if(_response.statusCode == 200){
  //     Map<String, dynamic> moviesMap = json.decode(_response.body);
  //     movies = moviesMap["results"].map<MovieModel>((e)=>MovieModel.fromJson(e)).toList();
  //     setState((){});
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome, Fiorella",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Discover",
                            style: TextStyle(
                              height: 1.25,
                              color: Colors.white,
                              fontSize: 38.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white12,
                      radius: 26.0,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    ),
                  ],
                ),
                //Sección de categorías

                //Sección del listado de películas
                const SizedBox(
                  height: 20.0,
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index){
                    return ItemMovieWidget(
                      movieModel: movies[index],
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
