class Player {
  final String name;
  final double price;
  final String img;

  const Player({required this.name, required this.price, required this.img});

  @override
  String toString() {
    return 'Player(Name: $name,  price: \$$price, imgUrl: $img';
  }
}
