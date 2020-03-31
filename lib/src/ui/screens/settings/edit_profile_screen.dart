import 'package:flutter/material.dart';
import 'package:igive2/src/bloc/provider.dart';
import 'package:igive2/src/providers/users_provider.dart';
import 'package:igive2/src/translations.dart';
import 'package:igive2/src/ui/widgets/app_back_button.dart';
import 'package:igive2/src/ui/widgets/app_background.dart';
import 'package:igive2/src/ui/widgets/buttons/app_button.dart';
import 'package:igive2/src/ui/widgets/app_textfield.dart';

class EditProfileScreen extends StatefulWidget {

  static const String routeName = '/editprofile';
  @override
  _EditProfileScreenState createState() => new _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final bloc = Provider.editProfileBloc();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _usersProvider = UsersProvider();
  TextStyle _buttonText = TextStyle(fontSize: 17, color: Colors.white);
  bool _isLoading = false;
  
  @override
  void initState(){
    super.initState();
    bloc.resetController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            AppBackground(),
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _profileIcon(),
                        SizedBox(height: 60.0),
                        _nameField(bloc),
                        _emailField(bloc),
                        _statusField(bloc),
                        SizedBox(height: 40.0),
                        _submitButton(bloc),
                        SizedBox(height: 40.0),
                        _deleteUser(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AppBackButton(),
            _isLoading
            ? Positioned.fill(
                child: Container(
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
            : Container()
          ],
        ),
      ),
    );
  }

  _translate(translation){
    return Translations.of(context).text(translation);
  }

  Widget _profileIcon(){
    return Center(
      child: InkWell(
        onTap: (){},
        child: Stack(
          children: <Widget>[
            Icon(
              Icons.supervised_user_circle,
              size: 150.0,
              color: Colors.black54,
            ),
            Positioned(
              right: 10.0,
              top: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(40.0)
                ),
                height: 40.0,
                width: 40.0,
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  _nameField(EditProfileBloc bloc){
    return StreamBuilder(
      stream: bloc.usernameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Username',
              style: TextStyle(
                fontSize: 17.0
              ),
            ),
            SizedBox(height: 5.0),
            AppTextField(
              hintText: 'current username',
              onChange: bloc.changeUsername,
              bloc: bloc,
              snapshot: snapshot,
            )
          ],
        );
      },
    );
  }
  _emailField(EditProfileBloc bloc){
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Email',
              style: TextStyle(
                fontSize: 17.0
              ),
            ),
            SizedBox(height: 5.0),
            AppTextField(
              hintText: 'current@email.com',
              onChange: bloc.changeEmail,
              bloc: bloc,
              snapshot: snapshot,
            )
          ],
        );
      },
    );
  }

  _statusField(EditProfileBloc bloc){
    return StreamBuilder(
      stream: bloc.statusStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Status',
              style: TextStyle(
                fontSize: 17.0
              ),
            ),
            SizedBox(height: 5.0),
            AppTextField(
              textType: TextInputType.multiline,
              hintText: 'current status !!!',
              onChange: bloc.changeStatus,
              bloc: bloc,
              snapshot: snapshot,
            )
          ],
        );
      },
    );
  }

  Widget _submitButton(EditProfileBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: AppButton(
            color: Colors.black38,
            name: 'Save',
            textStyle: _buttonText,
            onPressed: () => _submitPress(context, bloc, snapshot),
          ),
        );
      },
    );
  }

  Widget _deleteUser(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: AppButton(
        color: Colors.red[300],
        name: 'Delete User',
        textStyle: _buttonText,
        onPressed: () => _deletePress(),
      ),
    );
  }

  _submitPress(BuildContext context, EditProfileBloc bloc, AsyncSnapshot snapshot) async{
    if(snapshot.hasData){

    }else{
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar('Please complete the fields')
      );
    }
  }

  _deletePress() async{
    setState(() {
      _isLoading = true;
    });
    Map info = await _usersProvider.deleteUser();
    if(info['ok']){
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> r) => false);
    }else{
      setState(() {
        _isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        _showSnackBar(_translate(info['message']))
      );
    }
  }

  Widget _showSnackBar(translation){
    return SnackBar(
      duration: Duration(seconds: 2),
      content: Container(
        height: 40.0,
        child: Center(child: Text(translation, style: TextStyle(color: Color(0xffff9292)))),
      ),
    );
  }
}