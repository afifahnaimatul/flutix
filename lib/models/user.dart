part of 'models.dart';

class LocalUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePict;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int balance;

  LocalUser(this.id, this.email,
      {this.name,
      this.profilePict,
      this.selectedGenres,
      this.selectedLanguage,
      this.balance});

  LocalUser copyWith({String name, String profilePict, int balance}) =>
      LocalUser(this.id, this.email,
          name: name ?? this.name,
          profilePict: profilePict ?? this.profilePict,
          balance: balance ?? this.balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  @override
  String toString() {
    return '[$id] - $name, $email';
  }

  @override
  List<Object> get props => [
        id,
        email,
        name,
        profilePict,
        selectedGenres,
        selectedLanguage,
        balance,
      ];
}
