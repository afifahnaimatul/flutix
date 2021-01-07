part of 'pages.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final auth = FirebaseAuth.instance;

  List<String> images = [
    'https://mk0movieguide99l7786.kinstacdn.com/wp-content/uploads/2017/07/MV5BOWEzNWZkZWMtMDc2Ni00NTQxLWI5YzMtMDFjODFkNDAwNTkzXkEyXkFqcGdeQXVyMjIyNjMzODc@._V1_SY1000_CR006751000_AL_.jpg',
    'https://i.pinimg.com/originals/99/e6/d0/99e6d0954b61517c3da1a36b2b24bbaf.jpg',
    'https://m.media-amazon.com/images/M/MV5BMjAzMTI1MjMyN15BMl5BanBnXkFtZTgwNzU5MTE2NjM@._V1_.jpg',
    'https://m.media-amazon.com/images/M/MV5BNTBlZmE4YzItNTY5Mi00NmIxLTlhZTAtOWIxNjFlNTMzNmI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg',
    'https://m.media-amazon.com/images/I/71Uqy34noML._AC_SY741_.jpg',
  ];

  List<String> logos = [
    'assets/logos/drama.png',
    'assets/logos/drama.png',
    'assets/logos/drama.png',
    'assets/logos/drama.png',
  ];

  var discount = [
    {
      'title': 'Weekend Out',
      'subtitle': 'Hang the weekend out for 2 people',
      'discount': '50%',
    },
    {
      'title': 'Family Pack',
      'subtitle': 'Have fun in the movie',
      'discount': '70%'
    },
    {
      'title': 'Halloween Marathon',
      'subtitle': 'A lot of movies on the go',
      'discount': '80%'
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (imageFileToUpload != null) {
      uploadImage(imageFileToUpload).then((downloadURL) {
        imageFileToUpload = null;
        context.bloc<UserBloc>().add(UpdateData(profileImage: downloadURL));
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // return SingleChildScrollView(
      //   child: SafeArea(
      //     child: Container(
      //       color: Color(0xFFF5F7F9),
      //       child: Column(
      children: [
        customAppBar(),
        // Container(

        // ),
        // Container(
        //   padding: EdgeInsets.all(24),
        //   child: Column(
        //     children: [
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          // padding: EdgeInsets.only(top: 6, bottom: 12),
          child: Text(
            'Now Playing',
            style: blackTextFont.copyWith(
                fontSize: 20, fontWeight: FontWeight.w700),
          ),
          // child: SubHeaderText(text: 'Now Playing'),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
            if (movieState is MovieLoaded) {
              List<Movie> movies = movieState.movies.sublist(0, 10);

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 8),
                  child: MovieCard(
                    movies[index],
                    onTap: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToMovieDetail(movies[index]));
                    },
                  ),
                  // child: Text(movies[index].title),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
          }),
        ),
        // nowPlaying(),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          // padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'Browse Your Favorite Movies',
            style: blackTextFont.copyWith(
                fontSize: 20, fontWeight: FontWeight.w700),
          ),
          // child: SubHeaderText(text: 'Browse Your Favorite Movies'),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      userState.localUser.selectedGenres.length,
                      (index) => BrowseButton(
                          userState.localUser.selectedGenres[index])),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
          },
        ),
        // browseFavorite(),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          // padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'Coming Soon',
            style: blackTextFont.copyWith(
                fontSize: 20, fontWeight: FontWeight.w700),
          ),
          // child: SubHeaderText(text: 'Coming Soon'),
        ),
        SizedBox(
          height: 180,
          child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
            if (movieState is MovieLoaded) {
              List<Movie> movies = movieState.movies.sublist(10, 20);

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 8),
                  child: ComingSoonCard(movies[index]),
                  // child: Text(movies[index].title),
                ),
              );
            } else {
              return SpinKitFadingCircle(
                color: mainColor,
                size: 50,
              );
            }
          }),
        ),
        // comingSoon(),
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          // padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'Your Lucky Day',
            style: blackTextFont.copyWith(
                fontSize: 20, fontWeight: FontWeight.w700),
          ),
          // child: SubHeaderText(text: 'Your Lucky Day'),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: MaterialButton(
              color: Colors.red,
              child: Text('Log Out'),
              onPressed: () {
                AuthServices.signOut();
              }),
        ),
        Column(
          children: dummyPromos
              .map((e) => Padding(
                  padding:
                      EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 8),
                  child: PromoCard(e)))
              .toList(),
        ),
        SizedBox(height: 100),

        // luckyDayTickets(),

        // RaisedButton(
        //   child: Text("Log Out"),
        //   onPressed: () {
        //     auth.signOut();
        //     Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => LoginScreen()));
        //   },
        // ),
        //       ],
        //     ),
        //   ),
      ],
      // ),
      // ),
      // ),
      // ),
    );
  }

  Widget customAppBar() => Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
        decoration: BoxDecoration(
          color: accentColor1,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => (userState is UserLoaded)
              ? Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF5F558B), width: 1),
                      ),
                      child: Stack(
                        children: [
                          SpinKitFadingCircle(color: accentColor2, size: 50),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: (userState.localUser.profilePict == null
                                    ? AssetImage(
                                        'assets/images/user-default.png')
                                    : NetworkImage(
                                        userState.localUser.profilePict)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // CircleAvatar(
                          //   backgroundImage:
                          //       AssetImage('assets/images/profile.jpg'),
                          //   radius: 30,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(bottom: 4),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width -
                                (2 * defaultMargin) -
                                78,
                            child: Text(
                              userState.localUser.name,
                              style: whiteTextFont.copyWith(fontSize: 24),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                                  locale: "id_ID",
                                  decimalDigits: 0,
                                  symbol: 'IDR ')
                              .format(userState.localUser.balance),
                          style: yellowNumberFont.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : SpinKitFadingCircle(
                  color: accentColor2,
                  size: 50,
                ),
        ),
      );

  Widget nowPlaying() => Container(
      height: 175,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 8),
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => DetailMovieScreen()));
            },
          );
        },
      ));

  Widget browseFavorite() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: logos.map((e) {
        return GestureDetector(
          child: Container(
            height: 75,
            width: 75,
            child: Center(
              child: Image(
                image: AssetImage(e),
                height: 50,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple[50],
            ),
          ),
          onTap: () {},
        );
      }).toList());

  Widget comingSoon() => Container(
      height: 175,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              width: 125,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(images[index]), fit: BoxFit.cover),
              ),
            ),
            onTap: () {},
          );
        },
      ));

  Widget luckyDayTickets() => Column(
        children: discount.map((e) {
          return GestureDetector(
            child: Container(
              height: 125,
              width: double.infinity,
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: darkPurple,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 190,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e['title'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          e['subtitle'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          'OFF',
                          style: TextStyle(color: yellow, fontSize: 30),
                        ),
                      ),
                      Container(
                        child: Text(
                          e['discount'],
                          style: TextStyle(
                              color: yellow,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {},
          );
        }).toList(),
      );
}
