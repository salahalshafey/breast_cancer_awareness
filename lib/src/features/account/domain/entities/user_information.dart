import '../../data/models/user_information_model.dart';

class UserInformation {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? imageUrl;
  final DateTime dateOfSignUp;
  final UserTypes userType;

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
    UserTypes? userType,
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

  String get userTypeToString {
    switch (userType) {
      case UserTypes.doctor:
        return "Doctor";

      case UserTypes.patient:
        return "Patient";

      case UserTypes.normal:
        return "Normal";

      case UserTypes.guest:
        return "Guest";
    }
  }

  static UserTypes userTypeFromString(String userType) {
    switch (userType) {
      case "Doctor":
        return UserTypes.doctor;

      case "Patient":
        return UserTypes.patient;

      case "Normal":
        return UserTypes.normal;

      case "Guest":
        return UserTypes.guest;

      default:
        return UserTypes.normal;
    }
  }

  @override
  String toString() {
    return "id = $id, \n"
        "firstName = $firstName, \n"
        "lastName = $lastName, \n"
        "email = $email, \n"
        "phoneNmber = $phoneNumber, \n"
        "imageUrl = $imageUrl, \n"
        "dateOfSignUp = $dateOfSignUp, \n"
        "userType = $userTypeToString \n";
  }
}

enum UserTypes {
  doctor,
  patient,
  normal,
  guest,
}

extension UserTypesExtension on UserTypes {
  String toStringValue() {
    switch (this) {
      case UserTypes.doctor:
        return "Doctor";

      case UserTypes.patient:
        return "Patient";

      case UserTypes.normal:
        return "Normal";

      case UserTypes.guest:
        return "Guest";
    }
  }
}
