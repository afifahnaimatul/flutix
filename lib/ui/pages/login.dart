part of 'pages.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // other tutorial
  String _email, _password;
  final auth = FirebaseAuth.instance;

  // bwa tutorial
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8,
                    ),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 15),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome Back\nExplorer!",
                      style: blackTextFont.copyWith(fontSize: 45),
                      // style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      // cursorColor: darkPurple,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        // labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: darkPurple),
                        // ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                          // _email = value.trim();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        // labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: darkPurple),
                        // ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                          // _password = value.trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                      height: 60,
                      minWidth: double.infinity,
                      color: isEmailValid && isPasswordValid
                          ? mainColor
                          : Color(0xFF000000),
                      // : Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: Colors.white,
                            )
                          : Text(
                              "Sign In",
                              style: isEmailValid && isPasswordValid
                                  ? whiteTextFont.copyWith(fontSize: 24)
                                  : TextStyle(
                                      color: Color(0xFFBEBEBE), fontSize: 24),
                              // style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                      onPressed: isEmailValid && isPasswordValid
                          ? () async {
                              setState(() {
                                isSigningIn = true;
                              });

                              SignInSignUpResult result =
                                  await AuthServices.signIn(
                                      emailController.text,
                                      passwordController.text);

                              if (result.localUser == null) {
                                setState(() {
                                  isSigningIn = false;
                                });

                                Flushbar(
                                  duration: Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: result.message,
                                )..show(context);
                              }
                            }
                          : null
                      // AuthServices.signIn('pipah@email.com', 'asd123')
                      // onPressed: () async {
                      // try {
                      //   await auth
                      //       .signInWithEmailAndPassword(
                      //           email: _email, password: _password)
                      //       .then((_) {
                      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //         builder: (context) => HomePage()));
                      //   });
                      // } catch (e) {
                      //   print(e.message);
                      //   Fluttertoast.showToast(msg: e.code);
                      // }
                      // },
                      ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Text(
                          "Forgot password?",
                          style: purpleTextFont,
                        ),
                        onTap: () {},
                      ),
                      // SizedBox(width: 153),
                      Row(
                        children: [
                          Text("New here?",
                              style: greyTextFont.copyWith(
                                  fontWeight: FontWeight.w400)),
                          SizedBox(width: 8),
                          InkWell(
                            child: Text("Sign up", style: purpleTextFont),
                            // ),
                            onTap: () {
                              context.bloc<PageBloc>().add(
                                  GoToRegistrationPage(RegistrationData()));
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) => SignUpScreen()));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
