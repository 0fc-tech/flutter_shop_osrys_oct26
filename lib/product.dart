class Product {
  //Définir les propriétés du produit
  final int id;
  final String name;
  final String description;
  final num price;
  final String image;
  final String category;
  //Constructeur avec paramètres nommés (required)
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });
  //Méthode qui retourne le prix en euro
  String getPriceInEuro() => "$price€";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.name,
      'description': this.description,
      'price': this.price,
      'image': this.image,
      'category': this.category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      image: map['image'] as String,
      category: map['category'] as String,
    );
  }
}
