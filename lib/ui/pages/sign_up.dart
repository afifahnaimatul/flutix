part of 'pages.dart';

class SignUpScreen extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpScreen(this.registrationData);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // from other tutorial
  String _email, _password;
  final auth = FirebaseAuth.instance;

  // from bwa
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text(
        //     "Create Account",
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
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24, bottom: 50),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Icon(Icons.arrow_back, color: Colors.black),
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            'Create Account',
                            style: blackTextFont.copyWith(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 124,
                    child: Stack(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (widget.registrationData.profilePict ==
                                        null)
                                    ? AssetImage(
                                        'assets/images/user-default.png')
                                    : FileImage(
                                        widget.registrationData.profilePict),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        (widget.registrationData.profilePict ==
                                                null)
                                            ? 'assets/images/icon-plus.png'
                                            : 'assets/images/icon-remove.png'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            onTap: () async {
                              if (widget.registrationData.profilePict == null) {
                                widget.registrationData.profilePict =
                                    await getImage();
                              } else {
                                widget.registrationData.profilePict = null;
                              }

                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 50),
                  //   child: Image(
                  //     image: AssetImage('assets/images/logo.png'),
                  //     height: 120,
                  //   ),
                  // ),
                  // MainTextField(label: 'Name'),
                  Container(
                    padding: EdgeInsets.only(top: 40, bottom: 4.0),
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
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
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  FloatingActionButton(
                    backgroundColor: mainColor,
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (!(nameController.text.trim() != '' &&
                          emailController.text.trim() != '' &&
                          passwordController.text.trim() != '' &&
                          confirmPasswordController.text.trim() != '')) {
                        Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Please fill all the fields")
                          ..show(context);
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message:
                                "Mismatch password and confirmation password")
                          ..show(context);
                      } else if (passwordController.text.length < 6) {
                        Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Password's length min 6 characters")
                          ..show(context);
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Wrong email address")
                          ..show(context);
                      } else {
                        widget.registrationData.name = nameController.text;
                        widget.registrationData.email = emailController.text;
                        widget.registrationData.password =
                            passwordController.text;

                        context.bloc<PageBloc>().add(
                            GoToAccountAttributePage(widget.registrationData));
                      }
                    },
                  ),
                  // MaterialButton(
                  //   height: 60,
                  //   minWidth: double.infinity,
                  //   color: darkPurple,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: Text(
                  //     "Sign Up",
                  //     style: TextStyle(color: Colors.white, fontSize: 24),
                  //   ),
                  //   onPressed: () async {
                  //     SignInSignUpResult result = await AuthServices.signUp(
                  //         'pipah@email.com',
                  //         'asd123',
                  //         'Pipah',
                  //         ['Action', 'Horror', 'Music', 'Drama'],
                  //         'Korea');

                  //     if (result.localUser == null) {
                  //       print(result.message);
                  //     } else {
                  //       print(result.localUser.toString());
                  //     }
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => SignUpAttributesScreen()));
                  // },
                  // onPressed: () async {
                  //   try {
                  //     await auth
                  //         .createUserWithEmailAndPassword(
                  //             email: _email, password: _password)
                  //         .then((_) {
                  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //           builder: (context) => HomePage()));
                  //     });
                  //   } catch (e) {
                  //     print(e.message);
                  //     Fluttertoast.showToast(msg: e.code);
                  //   }
                  // },
                  // ),
                  SizedBox(height: 30),
                  // MaterialButton(
                  //     height: 60,
                  //     minWidth: double.infinity,
                  //     color: darkPurple,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Text(
                  //       "Sign In Trial",
                  //       style: TextStyle(color: Colors.white, fontSize: 24),
                  //     ),
                  //     onPressed: () async {
                  //       SignInSignUpResult result =
                  //           await AuthServices.signIn('pipah@email.com', 'asd124');

                  //       if (result.localUser == null) {
                  //         print(result.message);
                  //       } else {
                  //         print(result.localUser.toString());
                  //       }
                  //     }),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
