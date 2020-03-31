import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_event_bus/flutter_event_bus/EventBusWidget.dart';

import 'package:igive2/src/ui/screens/authentication/login_screen.dart';
import 'package:igive2/src/ui/screens/authentication/restorePassword/forgot_password_screen.dart';
import 'package:igive2/src/ui/screens/authentication/signup_screen.dart';
import 'package:igive2/src/ui/screens/community/add_study_screen.dart';
import 'package:igive2/src/ui/screens/authentication/confirm_mail_screen.dart';
import 'package:igive2/src/ui/screens/authentication/restorePassword/forgot_password_2_screen.dart';
import 'package:igive2/src/ui/screens/community/community_study_screen.dart';
import 'package:igive2/src/ui/screens/community/fit_kit_screen.dart';
import 'package:igive2/src/ui/screens/community/questionnaire_screen.dart';
import 'package:igive2/src/ui/screens/home/journey_screen.dart';
import 'package:igive2/src/ui/screens/home_screen.dart';
// import 'package:igive2/src/ui/screens/settings/behind_igive2_screen.dart';
import 'package:igive2/src/ui/screens/settings/edit_profile_screen.dart';
import 'package:igive2/src/ui/screens/settings/settings_screen.dart';
import 'package:igive2/src/ui/screens/settings/setup_screen.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/ui/screens/settings/terms_conditions_screen.dart';
import 'package:igive2/src/ui/screens/splash_screen.dart';
import 'package:igive2/src/ui/screens/statistics/statistics_screen.dart';
import 'package:igive2/src/utils/countries.dart';
import 'package:igive2/src/utils/medical_conditions.dart';
import 'package:igive2/src/translations.dart';





void main() {
  // final prefs = new UserPreferences();
  // await prefs.initPrefs();
  loadCountries();
  loadMedicalConditions();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return EventBusWidget(
      child: Provider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            const TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
          ],
          // home: HomeScreen(),
          home: IGive2App(),
          theme: ThemeData(

            accentColor: Colors.white,
            fontFamily: 'Montserrat',
            textTheme: TextTheme(
              body1: TextStyle( color: Colors.white, fontSize: 15.0),
            )
          ),
          // initialRoute: (prefs.token != null) ? HomeScreen.routeName : LoginScreen.routeName,
          routes: <String, WidgetBuilder>{
            LoginScreen.routeName: (BuildContext context) => LoginScreen(),
            ForgotPasswordScreen.routeName: (BuildContext context) => ForgotPasswordScreen(),
            SignUpScreen.routeName: (BuildContext context) => SignUpScreen(),
            AddStudyScreen.routeName: (BuildContext context) => AddStudyScreen(),
            ConfirmMailScreen.routeName: (BuildContext context) => ConfirmMailScreen(),
            ForgotPassword2Screen.routeName: (BuildContext context) => ForgotPassword2Screen(),
            CommunityStudyScreen.routeName: (BuildContext context) => CommunityStudyScreen(),
            SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
            SetUpScreen.routName: (BuildContext context) => SetUpScreen(),
            TermsConditionsScreen.routeName: (BuildContext context) => TermsConditionsScreen(),
            // BehindIgive2Screen.routeName: (BuildContext context) => BehindIgive2Screen(),
            QuestionnaireScreen.routeName: (BuildContext context) => QuestionnaireScreen(),
            EditProfileScreen.routeName: (BuildContext context) => EditProfileScreen(),
            FitKitScreen.routeName: (BuildContext context) => FitKitScreen(),
            StatisticsScreen.routeName: (BuildContext context) => StatisticsScreen(),
            HomeScreen.routeName: (BuildContext context) => HomeScreen(),
            JourneyScreen.routeName: (BuildContext context) => JourneyScreen(),
          }
        ),
      )
    );
  }
}

class IGive2App extends StatefulWidget{
  @override
  _IGive2AppState createState() => new _IGive2AppState();
}

class _IGive2AppState extends State<IGive2App>{
  @override
  Widget build(BuildContext context){
    return new SplashScreen();
  }
}

  
