class Addon {
  final String name;
  final double price;

  Addon({
    required this.name,
    required this.price,
  });

  factory Addon.fromJson(Map<String, dynamic> data) {
    return Addon(
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'Addon{name: $name, price: $price}';
  }
}
