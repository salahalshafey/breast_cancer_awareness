import '../entities/user_information.dart';
import '../repositories/account_repository.dart';

class GetUserInformationUsecase {
  final AccountRepository repository;

  GetUserInformationUsecase(this.repository);

  Future<UserInformation> call(String userId) =>
      repository.getUserInformation(userId);
}
