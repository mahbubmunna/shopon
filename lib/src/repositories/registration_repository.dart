



import 'package:sunbulahome/src/providers/registration_provider.dart';

class RegistrationRepository{

  static Future<dynamic> postRegistrationInfo(Map registrationInfo) async{
    return RegistrationProvider.postRegistrationInfo(registrationInfo);
  }
}