part of 'pages.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.only(top: 150.0, bottom: 50),
                // height: 175,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                )),
                // child: Image(
                //   image: AssetImage('assets/images/logo.png'),
                // ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 12, bottom: 16),
                child: Text(
                  "New Experience",
                  style: blackTextFont.copyWith(fontSize: 40),
                  // style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
                ),
              ),
              // Padding(
              // padding: EdgeInsets.only(bottom: 40, left: 24, right: 24),
              // padding: EdgeInsets.only(bottom: 125, left: 24, right: 24),
              // child: Text(
              Text(
                "Grab your movie tickets in an easier way",
                style: greyTextFont.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              // ),
              Container(
                //top 70 bottom 19
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5, bottom: 19),
                child: MaterialButton(
                  height: 60,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: mainColor,
                  child: Text(
                    "Get Started",
                    style: whiteTextFont.copyWith(fontSize: 24),
                    // style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    context
                        .bloc<PageBloc>()
                        .add(GoToRegistrationPage(RegistrationData()));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => SignUpScreen()));
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: InkWell(
                      child: Text(
                        "Sign In",
                        style: purpleTextFont,
                      ),
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToLoginPage());
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
