import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/model_movie.dart';
import 'package:flutter_netflix/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;

  CarouselImage({required List<Movie> movies}) :
    movies = movies;

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {

  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState(){
    super.initState();
    movies = widget.movies;
    images = movies.map((e) => Image.asset('./images/' + e.poster)).toList();
    keywords = movies.map((e) => e.keyword).toList();
    _currentKeyword = keywords[0];
    likes = movies.map((e) => e.like).toList();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding : EdgeInsets.all(20),
          ),
          CarouselSlider(
              items: images,
              options: CarouselOptions(
                autoPlay: false,
                height: 250,
                viewportFraction: 1.0,
                onPageChanged: (index, reason){
                  setState(() {
                    _currentPage = index;
                    _currentKeyword = keywords[index];
                  });
                }
              )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
                _currentKeyword,
                style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(children: <Widget>[
                    likes[_currentPage] ?
                    IconButton(icon: Icon(Icons.check), onPressed: () =>{}) :
                    IconButton(icon: Icon(Icons.add), onPressed: () =>{}),
                    Text(
                      '내가 찜한 콘텐츠',
                      style: TextStyle(fontSize: 11),
                    )
                  ],),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,),
                        Padding( padding: EdgeInsets.all(3)),
                        Text(
                          '재생',
                          style : TextStyle(color : Colors.black)
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return DetailScreen(movie: movies[_currentPage]);
                                    })
                            );
                          }),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: makeIndicator(likes, _currentPage),
              ))
        ],
      ),
    );
  }
}

List<Widget> makeIndicator (List list, int _currentPage) {
  List<Widget> results = [];
  for ( var i = 0 ; i < list.length; i++){
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == i ?
        Color.fromRGBO(255, 255, 255, 0.9) : Color.fromRGBO(255, 255, 255, 0.4)
      ),
    ));
  }

  return results;
}
