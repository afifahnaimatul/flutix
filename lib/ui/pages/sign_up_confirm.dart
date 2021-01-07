part of 'pages.dart';

class SignUpConfirm extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpConfirm(this.registrationData);

  @override
  _SignUpConfirmState createState() => _SignUpConfirmState();
}

class _SignUpConfirmState extends State<SignUpConfirm> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToAccountAttributePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text(
        //     'Comfirm Your Account',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   centerTitle: true,
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back, color: Colors.black),
        //       onPressed: () => Navigator.of(context).pushReplacement(
        //           MaterialPageRoute(builder: (context) => SplashScreen()))),
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                //     Container(
                // padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                // child: Column(
                //   children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 24, bottom: MediaQuery.of(context).size.height / 8),
                  height: 56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.black),
                          onTap: () {
                            context.bloc<PageBloc>().add(
                                GoToAccountAttributePage(
                                    widget.registrationData));
                          },
                        ),
                      ),
                      Center(
                        child: Text(
                          'Confirm\nYour Account',
                          style: blackTextFont.copyWith(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: (widget.registrationData.profilePict == null)
                            ? AssetImage('assets/images/user-default.png')
                            : FileImage(widget.registrationData.profilePict),
                        fit: BoxFit.cover),
                  ),
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage('assets/images/profile.jpg'),
                  //   radius: 100,
                  // ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, bottom: 8),
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                Container(
                  child: Text(
                    '${widget.registrationData.name}',
                    style: blackTextFont.copyWith(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),

                (isSigningUp)
                    ? SpinKitFadingCircle(color: Color(0xFF3E9D9D))
                    : Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6),
                        child: MaterialButton(
                          height: 60,
                          minWidth: double.infinity,
                          color: darkPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Create My Account",
                            style: whiteTextFont.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w700),
                            // style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          onPressed: () async {
                            setState(() {
                              isSigningUp = true;
                            });

                            SignInSignUpResult result =
                                await AuthServices.signUp(
                                    widget.registrationData.email,
                                    widget.registrationData.password,
                                    widget.registrationData.name,
                                    widget.registrationData.selectedGenres,
                                    widget.registrationData.selectedLang);

                            if (result.localUser == null) {
                              setState(() {
                                isSigningUp = false;
                              });

                              imageFileToUpload =
                                  widget.registrationData.profilePict;

                              Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: result.message)
                                ..show(context);
                            }

                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(builder: (context) => HomePage()),
                            // );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
