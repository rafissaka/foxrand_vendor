class Client {
  final String contactNumber;
  final String deliveryAddress;
  final String email;
  final String name;
  final String profilePic;
  final String token;

  Client({
    required this.contactNumber,
    required this.deliveryAddress,
    required this.email,
    required this.name,
    required this.profilePic,
    required this.token,
  });

  factory Client.fromFirestore(Map<String, dynamic> data) {
    return Client(
      contactNumber: data['contactNumber'] ?? '',
      deliveryAddress: data['deliveryAddress'] ?? '',
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      profilePic: data['profilePic'] ?? '',
      token: data['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contactNumber': contactNumber,
      'deliveryAddress': deliveryAddress,
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'token': token,
    };
  }
}
