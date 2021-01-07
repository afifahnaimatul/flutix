part of 'shared.dart';

Future<File> getImage() async {
  final picker = ImagePicker();
  var image = await picker.getImage(source: ImageSource.gallery);
  var pickedImage = File(image.path);

  return pickedImage;
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);

  return await (await task).ref.getDownloadURL();
}
