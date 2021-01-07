part of 'pages.dart';

class DetailMovieScreen extends StatelessWidget {
  final Movie movie;

  DetailMovieScreen(this.movie);

  final cast = [
    {
      'pict': 'https://miro.medium.com/max/918/1*B5xGNOx5DcodMJAswxQ7Rw.png',
      'name': 'Amybeth Mcnulty',
    },
    {
      'pict':
          'https://pbs.twimg.com/profile_images/1022419651580579840/Eo8VYWQc_400x400.jpg',
      'name': 'Lucas Jade',
    },
    {
      'pict':
          'https://www.academy.ca/wp-content/uploads/2019/02/Anne-with-an-E-Geraldine-James-Best-Supporting-Actress-Drama-COMP.jpg',
      'name': 'Geraldine James',
    },
    {
      'pict':
          'https://i.pinimg.com/564x/3e/32/1b/3e321bea8c515bc7b055742d8ce0fc80.jpg',
      'name': 'Dalila Bela',
    },
    {
      'pict':
          'https://i0.wp.com/www.tarragontheatre.com/wp-content/uploads/2014/10/Thomson-RH-headshot-1-UNTOUCHED-hi-rez-scaled.jpg?fit=300%2C240&ssl=1',
      'name': 'R.H. Thomson',
    },
  ];

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
            future: MovieServices.getDetails(movie),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                movieDetail = snapshot.data;
                return FutureBuilder(
                    future: MovieServices.getCredits(movie.id),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        credits = snapshot.data;
                        // return Text('a');
                        return SingleChildScrollView(
                            child: detailBody(movieDetail, credits, context));
                        // return Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(movieDetail.title),
                        //     Text(movieDetail.genresAndLanguage),
                        //     Container(
                        //       height: 150,
                        //       child: ListView(
                        //         scrollDirection: Axis.horizontal,
                        //         children:
                        //             credits.map((e) => Text(e.name)).toList(),
                        //       ),
                        //     ),
                        //   ],
                        // );
                      } else {}
                    });
              } else {}
            }),
        // body: SingleChildScrollView(
        //   child: SafeArea(
        //     child: Column(
        //       children: [
        // Container(
        //   height: 250,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: NetworkImage(
        //             'https://mk0movieguide99l7786.kinstacdn.com/wp-content/uploads/2017/07/MV5BOWEzNWZkZWMtMDc2Ni00NTQxLWI5YzMtMDFjODFkNDAwNTkzXkEyXkFqcGdeQXVyMjIyNjMzODc@._V1_SY1000_CR006751000_AL_.jpg'),
        //         fit: BoxFit.cover),
        //   ),
        // ),
        //         Container(
        //           padding: EdgeInsets.all(24),
        //           child: Column(
        //             children: [
        //               HeaderText(text: 'Anne With An E'),
        //               Container(
        //                 padding: EdgeInsets.symmetric(vertical: 6),
        //                 child: Text('Drama - English'),
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     Icons.star,
        //                     color: Colors.yellow,
        //                     size: 20,
        //                   ),
        //                   Icon(
        //                     Icons.star,
        //                     color: Colors.yellow,
        //                     size: 20,
        //                   ),
        //                   Icon(
        //                     Icons.star,
        //                     color: Colors.yellow,
        //                     size: 20,
        //                   ),
        //                   Icon(
        //                     Icons.star,
        //                     color: Colors.yellow,
        //                     size: 20,
        //                   ),
        //                   Icon(
        //                     Icons.star_half,
        //                     color: Colors.yellow,
        //                     size: 20,
        //                   ),
        //                   Container(
        //                     padding: EdgeInsets.only(left: 10),
        //                     child: Text('8/10',
        //                         style: TextStyle(color: Colors.grey)),
        //                   )
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //         // SubHeaderText(text: 'tryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy')
        //         // Container(
        //         //   child: Column(
        //         //     children: [
        //         Container(
        //           padding:
        //               EdgeInsets.only(top: 6, bottom: 12, right: 24, left: 24),
        //           child: SubHeaderText(text: 'Movie Cast'),
        //         ),
        //         Container(
        //           padding: EdgeInsets.only(left: 24),
        //           height: 75,
        //           child: ListView.builder(
        //               scrollDirection: Axis.horizontal,
        //               itemCount: cast.length,
        //               itemBuilder: (BuildContext context, int index) {
        //                 return Container(
        //                   margin: EdgeInsets.only(right: 8),
        //                   child: Text('a'),
        //                   width: 75,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(10),
        //                     image: DecorationImage(
        //                         image: NetworkImage(cast[index]['pict']),
        //                         fit: BoxFit.cover),
        //                   ),
        //                 );
        //               }),
        //         ),
        //         Container(
        //           padding:
        //               EdgeInsets.only(top: 30, bottom: 12, right: 24, left: 24),
        //           child: SubHeaderText(text: 'Description'),
        //         ),
        //         Container(
        //           padding: EdgeInsets.symmetric(horizontal: 24),
        //           child: Text(
        //             'Donec lobortis mauris quis imperdiet consequat. Vivamus facilisis lectus libero, vel rhoncus tellus placerat non. Vivamus malesuada, leo sed auctor viverra, nulla eros porta mi, sit amet facilisis magna urna vitae elit. Maecenas ac velit ac sapien viverra condimentum. Donec pulvinar luctus enim, non gravida felis. Aliquam non mi dignissim, rhoncus ex eget, elementum eros. Cras semper maximus fermentum. Praesent non orci ultricies lorem pharetra sagittis. Nam justo elit, pellentesque ac eros ut, porta sagittis ligula. Quisque ornare nibh nec augue vehicula commodo. Sed at nibh urna. Sed scelerisque finibus dolor, et auctor lorem tincidunt vel. Maecenas at purus eu ligula malesuada feugiat. Curabitur eu imperdiet quam.',
        //             style: TextStyle(
        //               fontSize: 16,
        //               height: 1.4,
        //             ),
        //           ),
        //         ),
        //         Container(
        //           margin: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
        //           child: MaterialButton(
        //             height: 60,
        //             minWidth: double.infinity,
        //             color: darkPurple,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(10)),
        //             child: Text(
        //               "Book This Movie",
        //               style: TextStyle(color: Colors.white, fontSize: 24),
        //             ),
        //             onPressed: () {},
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget detailBody(MovieDetail movieDetail, List<Credit> credits,
          BuildContext context) =>
      Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      imageBaseURL + 'w780' + movieDetail.backdropPath),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 8),
            child: Text(
              movieDetail.title,
              style: blackTextFont.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 8),
            child: Text(
              movieDetail.genresAndLanguage,
              style: blackTextFont.copyWith(fontSize: 14),
            ),
          ),
          RatingStars(
            voteAverage: movieDetail.voteAverage,
            starSize: 24,
            fontSize: 14,
            color: 'black',
            mainAlign: 'center',
          ),
          Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 12),
            alignment: Alignment.topLeft,
            child: Text(
              'Cast & Crew',
              style: blackTextFont.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: credits.length,
              itemBuilder: (_, index) => Container(
                width: 80,
                margin: EdgeInsets.only(
                  left: (index == 0) ? defaultMargin : 0,
                  right: (index == credits.length - 1) ? defaultMargin : 8,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          // image: AssetImage('assets/images/logo.png'),
                          image: NetworkImage(imageBaseURL +
                              'w780' +
                              credits[index].profilePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        credits[index].name,
                        style: blackTextFont,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 12),
            alignment: Alignment.topLeft,
            child: Text(
              'Storyline',
              style: blackTextFont.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
            child: Text(
              movieDetail.overview,
              style: blackTextFont.copyWith(fontSize: 18, height: 1.4),
              overflow: TextOverflow.clip,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 50),
            child: MaterialButton(
              height: 60,
              minWidth: double.infinity,
              color: darkPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Book Book Ulala",
                style: whiteTextFont.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToSelectSchedulePage(movieDetail));
              },
            ),
          ),
        ],
      );
}
