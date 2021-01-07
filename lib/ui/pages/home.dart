part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final navigator = [
    MovieScreen(),
    TopUpScreen(),
    TicketScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xFFF5F7F9),
            child: navigator[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: darkPurple,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: 'Movies',
            icon: Icon(Icons.slideshow),
          ),
          BottomNavigationBarItem(
            label: 'Top Up',
            icon: Icon(Icons.arrow_upward),
          ),
          BottomNavigationBarItem(
            label: 'My Tickets',
            icon: Icon(Icons.confirmation_num),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => navigator[index]));
        },
      ),
    );
  }
}
