part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 24, defaultMargin, 24),
                      height: 56,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.black),
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSelectSchedulePage(
                                widget.ticket.movieDetail));
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: EdgeInsets.fromLTRB(0, 24, defaultMargin, 24),
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.ticket.movieDetail.title,
                                style: blackTextFont.copyWith(fontSize: 18),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(imageBaseURL +
                                      'w154' +
                                      widget.ticket.movieDetail.posterPath),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 50, defaultMargin, 50),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                      child: Text('This is the screen', style: greyTextFont)),
                ),
                generateSeats(),
                Container(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Center(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => FloatingActionButton(
                        backgroundColor: (selectedSeats.length > 0)
                            ? mainColor
                            : Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: (selectedSeats.length > 0)
                              ? Colors.white
                              : Color(0xFFBEBEBE),
                        ),
                        onPressed: selectedSeats.length > 0
                            ? () {
                                context.bloc<PageBloc>().add(
                                        GoToCheckoutPage(widget.ticket.copyWith(
                                      seats: selectedSeats,
                                    )));
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            numberofSeats[i],
            (index) => Container(
              padding: EdgeInsets.only(
                  right: (index < numberofSeats[i] - 1) ? 16 : 0, bottom: 16),
              child: SelectableBox(
                "${String.fromCharCode(i + 65)}${index + 1}",
                width: 40,
                height: 40,
                isEnabled: index != 0,
                isSelected: selectedSeats
                    .contains("${String.fromCharCode(i + 65)}${index + 1}"),
                onTap: () {
                  String seatNumber =
                      "${String.fromCharCode(i + 65)}${index + 1}";
                  setState(() {
                    if (selectedSeats.contains(seatNumber)) {
                      selectedSeats.remove(seatNumber);
                    } else {
                      selectedSeats.add(seatNumber);
                    }
                  });
                },
              ),
            ),
          ),
        ),
      );
    }

    return Column(children: widgets);
  }
}
