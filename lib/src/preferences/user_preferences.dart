import 'package:shared_preferences/shared_preferences.dart';
class UserPreferences {

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //GET / SET notifications
  get activeNotifications{
    return _prefs.getBool('notifications' ?? false);
  }
  set activeNotifications(bool value){
    _prefs.setBool('notifications', value);
  }

  //GET / SET country
  get selectedCountry{
    return _prefs.getString('country' ?? '');
  }
  set selectedCountry(String value){
    _prefs.setString('country', value);
  }

  //GET / SET gende
  get selectedGender{
    return _prefs.getString('gender' ?? '');
  }
  set selectedGender(String value){
    _prefs.setString('gender', value);
  }

  //GET / SET medical condition
  get medicalCon{
    return _prefs.getString('medicalCon' ?? '');
  }
  set medicalCon(String value){
    _prefs.setString('medicalCon', value);
  }

  //GET / SET birthdate
  get birthdate{
    return _prefs.getString('birthdate' ?? '');
  }
  set birthdate(String value){
    _prefs.setString('birthdate', value);
  }

  //GET / SET height
  get height{
    return _prefs.getString('height' ?? '');
  }
  set height(String value){
    _prefs.setString('height', value);
  }

  //GET / SET weight
  get weight{
    return _prefs.getString('weight' ?? '');
  }
  set weight(String value){
    _prefs.setString('weight', value);
  }

  //GET / SET lang
  get systemLang{
    return _prefs.getString('lang' ?? '');
  }

  set systemLang(String value){
    _prefs.setString('lang', value);
  }


  // GET / SET studies
  get studiesNumber{
    return _prefs.getInt('study' ?? '');
  }
  set studies(int value){
    _prefs.setInt('study', value);
  }
}
