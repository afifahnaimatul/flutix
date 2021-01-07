part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  // @override
  // List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  List<Object> get props => [];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToRegistrationPage(this.registrationData);

  List<Object> get props => [];
}

class GoToAccountAttributePage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountAttributePage(this.registrationData);

  List<Object> get props => [];
}

class GoToAccountConfirmPage extends PageEvent {
  final RegistrationData registrationData;

  GoToAccountConfirmPage(this.registrationData);

  List<Object> get props => [];
}

class GoToMovieDetail extends PageEvent {
  final Movie movie;

  GoToMovieDetail(this.movie);

  List<Object> get props => [movie];
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;

  GoToSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;

  GoToSelectSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;

  GoToCheckoutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}
