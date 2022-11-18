import 'package:als_frontend/data/model/response/language_model.dart';
import 'package:als_frontend/util/app_constant.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstant.languagesList;
  }
}
