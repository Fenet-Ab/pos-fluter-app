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

  static List<Product> get dummyProducts => [
    Product(
      id: '1',
      name: 'Arki Water',
      price: 18.00,
      category: 'BEVERAGE',
      imageUrl: 'assets/images/arki.png',
      description: 'Refreshing water',
      stock: 100,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '2',
      name: 'Habesha Beer',
      price: 55.00,
      category: 'ALCHOL',
      imageUrl: 'assets/images/habesha.png',
      description: 'Cold beer',
      stock: 50,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '3',
      name: 'Coca Cola',
      price: 25.00,
      category: 'BEVERAGE',
      imageUrl: 'assets/images/coca.png',
      description: 'Sweet soda',
      stock: 200,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '4',
      name: 'pizza',
      price: 25.00,
      category: 'food',
      imageUrl: 'assets/images/pizza.png',
      description: 'Orange soda',
      stock: 150,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '5',
      name: 'Burger',
      price: 25.00,
      category: 'food',
      imageUrl: 'assets/images/burger.png',
      description: 'Lemon lime soda',
      stock: 120,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '6',
      name: 'Kitfo',
      price: 20.00,
      category: 'food',
      imageUrl: 'assets/images/kitfo.png',
      description: 'ethiopian food',
      stock: 80,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}
