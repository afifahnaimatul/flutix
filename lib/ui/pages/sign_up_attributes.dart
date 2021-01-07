part of 'pages.dart';

class SignUpAttributesScreen extends StatefulWidget {
  final List<String> genre = [
    'Horror',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime',
  ];
  final List<String> language = [
    'Bahasa',
    'English',
    'Japanese',
    'Korean',
  ];
  final RegistrationData registrationData;

  SignUpAttributesScreen(this.registrationData);

  @override
  _SignUpAttributesScreenState createState() => _SignUpAttributesScreenState();
}

class _SignUpAttributesScreenState extends State<SignUpAttributesScreen> {
  // var genre = [
  //   {'name': 'Horror'},
  //   {'name': 'Music'},
  //   {'name': 'Action'},
  //   {'name': 'Drama'},
  //   {'name': 'War'},
  //   {'name': 'Crime'},
  // ];

  // var language = [
  //   {'name': 'Bahasa'},
  //   {'name': 'English'},
  //   {'name': 'Japanese'},
  //   {'name': 'Korean'},
  // ];

  List<String> selectedGenre = [];
  String selectedLan = 'English';

  @override
  void initState() {
    super.initState();
    bool isTapped = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.registrationData.password = '';

        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back, color: Colors.black),
        //       onPressed: () => Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(builder: (context) => SplashScreen()))),
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24, bottom: 4),
                    height: 56,
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back, color: Colors.black),
                      onTap: () {
                        widget.registrationData.password = '';

                        context
                            .bloc<PageBloc>()
                            .add(GoToRegistrationPage(widget.registrationData));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 16),
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Your \nFavorite Genres",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: generateGenreWidgets(context)),
                  // Container(
                  //     padding: EdgeInsets.symmetric(vertical: 24),
                  //     child: listGenre()),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.only(bottom: 16),
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Your \nLanguage",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: generateLangWidgets(context)),
                  // Container(
                  //     padding: EdgeInsets.symmetric(vertical: 24),
                  //     child: listLanguage()),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 50),
                    child: Center(
                        child: FloatingActionButton(
                      backgroundColor: mainColor,
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (selectedGenre.length != 4) {
                          Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Please select 4 genres")
                            ..show(context);
                        } else {
                          widget.registrationData.selectedGenres =
                              selectedGenre;
                          widget.registrationData.selectedLang = selectedLan;

                          context.bloc<PageBloc>().add(
                              GoToAccountConfirmPage(widget.registrationData));
                        }
                      },
                    )),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 50),
                  //   child: MaterialButton(
                  //     minWidth: 25,
                  //     height: 65,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(50)),
                  //     color: darkPurple,
                  //     child: Icon(
                  //       Icons.arrow_forward,
                  //       color: Colors.white,
                  //       size: 34,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => SignUpConfirm()));
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listGenre() => GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: widget.genre.map(
          (e) {
            // var genre = {
            //   'name': e['name'],
            // };
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedGenre.contains(e) ? yellow : Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: selectedGenre.contains(e) ? yellow : Colors.white,
                ),
              ),
              onTap: () {
                setState(() {
                  // isTapped = !isTapped;
                  if (selectedGenre.contains(e)) {
                    selectedGenre.remove(e);
                  } else if (selectedGenre.length < 4) {
                    selectedGenre.add(e);
                  }
                });
              },
            );
          },
        ).toList(),
      );

  Widget listLanguage() => GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: widget.language.map(
          (e) {
            // List data = [];
            // var language = {
            //   'name': e['name'],
            // };
            // data.add(genre);
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: selectedLan == e ? yellow : Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: selectedLan == e ? yellow : Colors.white,
                ),
              ),
              onTap: () {
                setState(() {
                  if (selectedLan == '') {
                    selectedLan = e;
                  } else if (selectedLan == e) {
                    selectedLan = '';
                  }
                });
              },
            );
          },
        ).toList(),
      );

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        ((MediaQuery.of(context).size.width) - 2 * defaultMargin - 10) / 2;

    return widget.genre
        .map(
          (e) => SelectableBox(
            e,
            width: width,
            isSelected: selectedGenre.contains(e),
            onTap: () {
              onSelectGenre(e);
            },
          ),
        )
        .toList();
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        ((MediaQuery.of(context).size.width) - 2 * defaultMargin - 10) / 2;

    return widget.language
        .map(
          (e) => SelectableBox(
            e,
            width: width,
            isSelected: selectedLan == e,
            onTap: () {
              setState(() {
                selectedLan = e;
              });
            },
          ),
        )
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenre.contains(genre)) {
      setState(() {
        selectedGenre.remove(genre);
      });
    } else {
      if (selectedGenre.length < 4) {
        setState(() {
          selectedGenre.add(genre);
        });
      }
    }
  }
}
