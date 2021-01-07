part of 'widgets.dart';

class HeaderText extends StatelessWidget {
  String text;

  HeaderText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
    );
  }
}
