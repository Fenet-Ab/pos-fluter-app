enum UserRole { admin, cashier, manager }

class User {
  final String id;
  final String name;
  final String pin;
  final String email;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.pin,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      pin: json['pin'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'pin': pin, 'email': email, 'role': role};
  }

  static final List<User> dummyUsers = [
    User(
      id: '1',
      name: 'Admin User',
      pin: '123456',
      email: 'admin@savvy.com',
      role: UserRole.admin,
    ),
    User(
      id: '2',
      name: 'Cashier User',
      pin: '654321',
      email: 'cashier@savvy.com',
      role: UserRole.cashier,
    ),
  ];
}
