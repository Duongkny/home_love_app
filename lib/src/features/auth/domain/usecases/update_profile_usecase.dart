import 'package:homelove/src/features/auth/domain/entites/profile_information.dart';
import 'package:injectable/injectable.dart';


import '../repos/auth_repo.dart';

@injectable
class UpdateProfileUseCase {
  final AuthRepo _repo;

  const UpdateProfileUseCase(this._repo);

  Future<void> call({
    required ProfileInformation information,
  }) async {
    if (information.fullName.trim().isEmpty) {
      throw ArgumentError('Vui lòng nhập họ tên');
    }

    if (information.dateOfBirth.isAfter(DateTime.now())) {
      throw ArgumentError('Ngày sinh không hợp lệ');
    }

    await _repo.updateProfile(information);
  }
}
