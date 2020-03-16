import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/models/user.dart';
import 'package:driver/screens/homepage.dart';
import 'package:driver/screens/rt1.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final usersRef = Firestore.instance.collection('users');
User currentUser;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber;
  String phoneIsoCode;
  String interNumber;
  bool rules = true;
  String smsCode;
  String _verificationId;
  String _message;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
      interNumber = internationalizedPhoneNumber;
    });
  }

  bool get isValid =>
      rules == true &&
      interNumber != null &&
      phoneNumber != null &&
      phoneNumber.length == 10;

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      smsCodeDialog(context);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: interNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: this.smsCode,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    getUser(user);
  }

  createUser(FirebaseUser user) async {
    setState(() {
      isLoggedIn = true;
    });
    await usersRef.document(user.uid).setData({
      "phone": this.interNumber,
      "uid": user.uid,
      "created": DateTime.now(),
      "hasTransport": false,
      "balance": 1000.00
    });

    DocumentSnapshot doc = await usersRef.document(user.uid).get();

    currentUser = User.fromDocument(doc);
    setState(() {
      isLoggedIn = false;
    });
    if (!currentUser.hasTransport) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RT1()));
    }
  }

  getUser(FirebaseUser user) async {
    setState(() {
      isLoggedIn = true;
    });
    DocumentSnapshot doc = await usersRef.document(user.uid).get();
    if (!doc.exists) {
      createUser(user);
    } else {
      currentUser = User.fromDocument(doc);
      if (!currentUser.hasTransport) {
        setState(() {
          isLoggedIn = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => RT1()));
      }
    }
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Введите код"),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text("Подтвердить"),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      getUser(user);
                    } else {
                      Navigator.of(context).pop();
                      _signInWithPhoneNumber();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: isLoggedIn,
        opacity: 0.7,
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: 260.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 250.0,
                  child: TextLiquidFill(
                    text: 'TiD',
                    waveColor: Colors.blueAccent,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 90.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 150.0,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: 100.0,
                  child: InternationalPhoneInput(
                    enabledCountries: ['RU'],
                    hintText: 'Номер телефона',
                    errorText: 'Введите корректный номер',
                    initialPhoneNumber: phoneNumber,
                    initialSelection: phoneIsoCode,
                    onPhoneNumberChange: onPhoneNumberChange,
                  ),
                ),
                SizedBox(height: 20.0),
                CheckboxListTile(
                    title: Text('Согласен с правилами использования'),
                    value: rules,
                    onChanged: (value) {
                      setState(() {
                        rules = value;
                      });
                    }),
                SizedBox(height: 20.0),
                FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: isValid ? _verifyPhoneNumber : null,
                  child: Text('Далее'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
