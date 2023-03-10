class UserInformation {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? imageUrl;
  final DateTime dateOfSignUp;
  final String userType;

  const UserInformation({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.dateOfSignUp,
    required this.userType,
  });

  UserInformation copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
    DateTime? dateOfSignUp,
    String? userType,
  }) {
    return UserInformation(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      dateOfSignUp: dateOfSignUp ?? this.dateOfSignUp,
      userType: userType ?? this.userType,
    );
  }

  @override
  String toString() {
    return "id = $id, \n"
        "first Name = $firstName, \n"
        "lastName = $lastName, \n"
        "email = $email, \n"
        "imageUrl = $imageUrl, \n"
        "dateOfSignUp = $dateOfSignUp, \n"
        "userType = $userType \n";
  }
}
