part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(LocalUser localUser) async {
    _userCollection.doc(localUser.id).set({
      'email': localUser.email,
      'name': localUser.name,
      'balance': localUser.balance,
      'selectedGenres': localUser.selectedGenres,
      'selectedLanguage': localUser.selectedLanguage,
      'profilePict': localUser.profilePict
    });
  }

  static Future<LocalUser> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    var result = snapshot.data();
    return LocalUser(id, result['email'],
        balance: result['balance'],
        profilePict: result['profilePict'],
        selectedGenres: (result['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: result['selectedLanguage'],
        name: result['name']);
  }
}
