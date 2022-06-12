String priceToString(double price) {
  String result = (price / 1000000).toStringAsFixed(1);
  return '\$ $result M';
}
