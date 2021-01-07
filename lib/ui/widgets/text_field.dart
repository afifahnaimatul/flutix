part of 'widgets.dart';

class MainTextField extends StatelessWidget {
  String label;
  TextInputType type;
  bool obscureText;

  MainTextField({
    Key key,
    @required this.label,
    this.type,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        keyboardType: type,
        cursorColor: darkPurple,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkPurple),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
