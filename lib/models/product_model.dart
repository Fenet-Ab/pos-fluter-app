class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  final int stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory method to create a product from a map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      stock: json['stock'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // method to convert a product to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'stock': stock,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
