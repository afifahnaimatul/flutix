part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            child: Center(
              child: Image(
                image: AssetImage('assets/logos/drama.png'),
                height: 50,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple[50],
            ),
          ),
          Text(genre),
        ],
      ),
      onTap: () {},
    );
  }
}
