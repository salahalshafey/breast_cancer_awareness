import '../../data/models/user_information_model.dart';

class UserInformation {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? imageUrl;
  final DateTime dateOfSignUp;
  final String userType;

  const UserInformation({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.dateOfSignUp,
    required this.userType,
  });

  UserInformation copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? imageUrl,
    DateTime? dateOfSignUp,
    String? userType,
  }) {
    return UserInformation(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      dateOfSignUp: dateOfSignUp ?? this.dateOfSignUp,
      userType: userType ?? this.userType,
    );
  }

  UserInformation copyWithImageUrl(String? imageUrl) {
    return UserInformation(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
      dateOfSignUp: dateOfSignUp,
      userType: userType,
    );
  }

  UserInformation copyWithPhoneNumber(String? phoneNumber) {
    return UserInformation(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
      dateOfSignUp: dateOfSignUp,
      userType: userType,
    );
  }

  UserInformationModel toModel() => UserInformationModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        dateOfSignUp: dateOfSignUp,
        userType: userType,
      );

  @override
  String toString() {
    return "id = $id, \n"
        "firstName = $firstName, \n"
        "lastName = $lastName, \n"
        "email = $email, \n"
        "phoneNmber = $phoneNumber, \n"
        "imageUrl = $imageUrl, \n"
        "dateOfSignUp = $dateOfSignUp, \n"
        "userType = $userType \n";
  }
}
