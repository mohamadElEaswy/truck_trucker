import 'package:truck_trucker/src/data/models/user_model.dart';
import 'package:truck_trucker/src/domain/repository/repository.dart';

class RepositoryController {
  final MainRepository _repository = Repository();

  Future<UserModel?> getUserData() async {
    return await _repository.getUserData();
  }

  Future<void> signOut() async {
    return await _repository.signOut();
  }
}