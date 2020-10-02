
import 'package:sunbulahome/src/models/user.dart';
import 'package:sunbulahome/src/providers/user_provider.dart';


class UserRepository {

  static Future<UserResponse> getUser() {
    return UserProvider.getUser();
  }

  static Future<UserResponse> postUser(Map<String, dynamic> updatedData) {
    return UserProvider.postUserUpdatedData(updatedData);
  }
}