import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/models/user.dart';
import 'package:smartcommercebd/src/repositories/user_repository.dart';
import 'package:smartcommercebd/src/screens/signin.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:smartcommercebd/src/utils/common_utils.dart';

class ProfileSettingsDialog extends StatefulWidget {
  User user;
  VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  final userNameController = TextEditingController(text: appUser.name);
  final emailController = TextEditingController(text: appUser.email);
  final addressController = TextEditingController(text: appUser.address !=null ? appUser.address : '');
  final areaController = TextEditingController(text: appUser.area !=null ? appUser.area : '' );
  final cityController = TextEditingController(text: appUser.country !=null ? appUser.country : '');

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
         showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(UiIcons.user_1),
                    SizedBox(width: 10),
                    Text(
                      S.of(context).profileSettings,
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: userNameController,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: S.of(context).johnDoe, labelText: S.of(context).fullName),
                          validator: (input) => input.trim().length < 3 ? S.of(context).notAValidFullName : null,
                          onSaved: (input) => setState(() {
                            widget.user.name = input;
                            widget.onChanged();
                          }),
                        ),
                        new TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'johndo@gmail.com', labelText: S.of(context).emailAddress),
                          validator: (input) => !input.contains('@') ? S.of(context).notAValidEmail : null,
                          onSaved: (input) => widget.user.email = input,
                        ),
                        new TextFormField(
                          controller: addressController,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          decoration: getInputDecoration(hintText: S.of(context).enterYourAddress, labelText: S.of(context).address),
                          onSaved: (input) => widget.user.address = input,
                        ),
                        new TextFormField(
                          controller: areaController,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          decoration: getInputDecoration(hintText: S.of(context).enterYourArea, labelText: S.of(context).area),
                          onSaved: (input) => widget.user.area = input,
                        ),
                        new TextFormField(
                          controller: cityController,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          decoration: getInputDecoration(hintText: S.of(context).enterYourCity, labelText: S.of(context).city),
                          onSaved: (input) => widget.user.city = input,
                        ),

//                        FormField<String>(
//                          builder: (FormFieldState<String> state) {
//                            return DropdownButtonFormField<String>(
//                              decoration: getInputDecoration(hintText: 'Female', labelText: 'Gender'),
//                              hint: Text("Select Device"),
//                              value: widget.user.gender,
//                              onChanged: (input) {
//                                setState(() {
//                                  widget.user.gender = input;
//                                  widget.onChanged();
//                                });
//                              },
//                              onSaved: (input) => widget.user.gender = input,
//                              items: [
//                                new DropdownMenuItem(value: 'Male', child: Text('Male')),
//                                new DropdownMenuItem(value: 'Female', child: Text('Female')),
//                              ],
//                            );
//                          },
//                        ),
//                        FormField<String>(
//                          builder: (FormFieldState<String> state) {
//                            return DateTimeField(
//                              decoration: getInputDecoration(hintText: '1996-12-31', labelText: 'Birth Date'),
//                              format: new DateFormat('yyyy-MM-dd'),
//                              initialValue: widget.user.dateOfBirth,
//                              onShowPicker: (context, currentValue) {
//                                return showDatePicker(
//                                    context: context,
//                                    firstDate: DateTime(1900),
//                                    initialDate: currentValue ?? DateTime.now(),
//                                    lastDate: DateTime(2100));
//                              },
//                              onSaved: (input) => setState(() {
//                                widget.user.dateOfBirth = input;
//                                widget.onChanged();
//                              }),
//                            );
//                          },
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).cancel),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          S.of(context).save,
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        "Edit",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() async {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      Map<String, dynamic> updatedUserData = {
        'name' : userNameController.text,
        'email' : emailController.text,
        'address': addressController.text,
        'area' : areaController.text,
        'country' : cityController.text
      };
      await UserRepository.postUser(updatedUserData).then((response) {
        appUser = response.user;
      });
      Navigator.pop(context);
      AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          body: Text(S.of(context).saved)
      ).show();
      closeAwesomeDialog(context);
    }
  }
}
