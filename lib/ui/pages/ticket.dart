part of 'pages.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   // bottomNavigationBar: BottomNav(),
    //   body: Container(
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '!',
            style: TextStyle(
              fontSize: 150,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          Text(
            'Uh Oh!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'This page is under construction. Try again later!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
