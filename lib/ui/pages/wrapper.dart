part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (user == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
        // context.bloc<PageBloc>().add(GoToSplashPage());
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(user.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
        // context.bloc<PageBloc>().add(GoToMainPage());
      }
    }
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashScreen()
            : (pageState is OnLoginPage)
                ? LoginScreen()
                : (pageState is OnRegistrationPage)
                    ? SignUpScreen(pageState.registrationData)
                    : (pageState is OnAccountAttributePage)
                        ? SignUpAttributesScreen(pageState.registrationData)
                        : (pageState is OnAccountConfirmPage)
                            ? SignUpConfirm(pageState.registrationData)
                            : (pageState is OnMovieDetailPage)
                                ? DetailMovieScreen(pageState.movie)
                                : (pageState is OnSelectSchedulePage)
                                    ? SelectSchedulePage(pageState.movieDetail)
                                    : (pageState is OnSelectSeatPage)
                                        ? SelectSeatPage(pageState.ticket)
                                        : (pageState is OnCheckoutPage)
                                            ? CheckoutPage(pageState.ticket)
                                            : HomePage());
  }
}
