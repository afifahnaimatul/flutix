part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo({
    @required this.title,
    @required this.subtitle,
    @required this.discount,
  });

  @override
  // TODO: implement props
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromos = [
  Promo(
    title: 'Weekend Out',
    subtitle: 'Hang the weekend out for 2 people',
    discount: 50,
  ),
  Promo(
    title: 'Family Pack',
    subtitle: 'Have fun in the movie',
    discount: 70,
  ),
  Promo(
    title: 'Halloween Marathon',
    subtitle: 'A lot of movies on the go',
    discount: 80,
  )
];
