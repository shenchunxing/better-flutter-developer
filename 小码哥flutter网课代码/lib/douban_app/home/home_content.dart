import 'package:flutter/material.dart';
import 'package:flutter_app/douban_app/home/home_movie_item.dart';
import 'package:flutter_app/douban_app/model/home_model.dart';
import 'package:flutter_app/douban_app/service/home_request.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<MovieItem> movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //请求数据
    HomeRequest.requestMovieList(0).then((value) {
      setState(() {
         movies.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext ctx , int index) {
      return HYHomeMovieItem(movies[index]);
    },itemCount: movies.length,);
  }
}
