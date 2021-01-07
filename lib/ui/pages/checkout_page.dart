part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
        return;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
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
                            context
                                .bloc<PageBloc>()
                                .add(GoToSelectSeatPage(widget.ticket));
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 28, defaultMargin, 24),
                      child: Center(
                        child: Text(
                          "Checkout\nMovie",
                          style: blackTextFont.copyWith(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 24, horizontal: defaultMargin),
                  child: detailOfMovie(widget.ticket),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailOfMovie(Ticket ticket) => Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            width: 90,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    imageBaseURL + 'w342' + ticket.movieDetail.posterPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    90 -
                    16,
                child: Text(
                  ticket.movieDetail.title,
                  style: blackTextFont.copyWith(fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    90 -
                    16,
                child: Text(
                  ticket.movieDetail.genresAndLanguage,
                  style: greyTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              RatingStars(
                voteAverage: ticket.movieDetail.voteAverage,
                color: 'black',
              ),
            ],
          )
        ],
      );
}
