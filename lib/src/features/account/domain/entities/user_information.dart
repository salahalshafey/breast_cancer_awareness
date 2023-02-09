class UserInformation {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? imageURl;
  final DateTime dateOfSignUp;
  final String userType;

  const UserInformation({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageURl,
    required this.dateOfSignUp,
    required this.userType,
  });

  UserInformation copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? imageURl,
    DateTime? dateOfSignUp,
    String? userType,
  }) {
    return UserInformation(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imageURl: imageURl ?? this.imageURl,
      dateOfSignUp: dateOfSignUp ?? this.dateOfSignUp,
      userType: userType ?? this.userType,
    );
  }
}
