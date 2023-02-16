import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_information.dart';

class UserInformationModel extends UserInformation {
  const UserInformationModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.imageUrl,
    required super.dateOfSignUp,
    required super.userType,
  });

  factory UserInformationModel.fromFirestore(
      Map<String, dynamic> document, String documentId) {
    return UserInformationModel(
      id: documentId,
      firstName: document['first_name'],
      lastName: document['last_name'],
      email: document['email'],
      imageUrl: document['image_url'],
      dateOfSignUp: (document['date_of_sign_up'] as Timestamp).toDate(),
      userType: document['user_type'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'image_url': imageUrl,
        'date_of_sign_up': dateOfSignUp,
        'user_type': userType,
      };
}
