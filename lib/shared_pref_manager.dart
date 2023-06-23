import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager{
  static final SharedPrefManager _instance=SharedPrefManager._private();
  SharedPrefManager._private();
  static SharedPrefManager get instance=>_instance;
  void saveData(String key,String value)async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }
  Future<String?> getData(String key )async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
  static const String userId="userId";

}