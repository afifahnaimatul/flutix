part of 'extensions.dart';

extension FirebaseUserExtension on User {
  LocalUser convertToUser(
          {String name = 'No Name',
          List<String> selectedGenres = const [],
          String selectedLanguage = 'English',
          int balance = 50000}) =>
      LocalUser(this.uid, this.email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<LocalUser> fromFireStore() async =>
      await UserServices.getUser(this.uid);
}
