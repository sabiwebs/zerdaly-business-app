import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zerdaly_business_app/Token.dart';
import 'package:zerdaly_business_app/business_views/general.dart';
import 'package:zerdaly_business_app/model/business.dart';
import 'package:zerdaly_business_app/register/businessRegister.dart';

class BusinessLogin extends StatefulWidget {
  @override
  BusinessLoginState createState() => BusinessLoginState();
}

class BusinessLoginState extends State<BusinessLogin> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool emailValidation = false;
  bool passValidation = false;
  bool loginValidation = false;
  bool loginState = false;
  Business business = new Business();
  final token = Token.instance;

  @override
  Widget build(BuildContext context) {
    MediaQueryData screenInfo = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 144, 82, 1),
        body: ListView(
          children: <Widget>[
            Container(
                height: screenInfo.size.height * 0.22,
                child: Center(
                  child: Text(
                    "Zerdaly",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontSize: screenInfo.size.width * 0.15,
                    ),
                  ),
                )),
            Container(
              padding: EdgeInsets.all(5),
              height: screenInfo.size.height * 0.65,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: !loginValidation
                            ? Text(
                                'Login para negocios',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 144, 82, 1),
                                    fontFamily: 'Kanit',
                                    fontSize: screenInfo.size.width * 0.05),
                              )
                            : Container(
                                width: screenInfo.size.width * 0.80,
                                child: Card(
                                  color: Colors.red[400],
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                        child: Text(
                                      'Datos incorrectos, intentalo de nuevo.',
                                      style: TextStyle(
                                        fontFamily: 'Kanit',
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              )),
                    Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: screenInfo.size.width * 0.045,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            TextField(
                              controller: email,
                              onChanged: (text) {
                                setState(() {
                                  emailValidation = false;
                                  loginValidation = false;
                                });
                              },
                              style: TextStyle(
                                  fontSize: screenInfo.size.width * 0.045,
                                  fontFamily: 'Kanit'),
                              decoration: InputDecoration(
                                  hintText: 'juan@mail.com',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: screenInfo.size.width * 0.045),
                                  errorText: emailValidation
                                      ? 'Esta campo no puede estar vacío.'
                                      : null),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                            ),
                            Text(
                              'Contraseña',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: screenInfo.size.width * 0.045,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            TextField(
                              controller: password,
                              onChanged: (text) {
                                setState(() {
                                  passValidation = false;
                                  loginValidation = false;
                                });
                              },
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: screenInfo.size.width * 0.045,
                                  fontFamily: 'Kanit'),
                              decoration: InputDecoration(
                                  hintText: 'Tu contraseña',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Kanit',
                                      fontSize: screenInfo.size.width * 0.045),
                                  errorText: passValidation
                                      ? 'Esta campo no puede estar vacío.'
                                      : null),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    !loginState
                        ? GestureDetector(
                            child: Container(
                              width: screenInfo.size.width   * 0.33,
                              height: screenInfo.size.height  * 0.07,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Colors.orange[300],
                                Color.fromRGBO(255, 144, 82, 1)
                              ])),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Kanit',
                                      fontSize: screenInfo.size.width  * 0.045),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (email.text.isEmpty) {
                                setState(() {
                                  emailValidation = true;
                                });
                              } else if (password.text.isEmpty) {
                                setState(() {
                                  passValidation = true;
                                });
                              } else {
                                setState(() {
                                  emailValidation = false;
                                  passValidation = false;
                                  loginValidation = false;
                                });
                                login();
                              }
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    Spacer(),
                    GestureDetector(
                      child: Center(
                        child: Text(
                          'Registrate aqui',
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              color: Color.fromRGBO(255, 144, 82, 1),
                              fontSize: screenInfo.size.width  * 0.045),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusinessRegister()));
                      },
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  login() async {
    setState(() {
      loginState = true;
    });

    final result = await business.login(email.text, password.text);
    //Comprube que el login ha sido exitoso
    if (result[0] == "200") {
      setState(() {
        loginState = false;
      });
      //guardar token
      saveToken(result[2]);
    } else {
      setState(() {
        loginValidation = true;
        loginState = false;
      });
    }
  }

  saveToken(String auth) async {
    Token token = Token.instance;
    Map<String, dynamic> row = {
      Token.columnKind: "Business",
      Token.columnAuth: auth
    };

    final id = await token.insert(row);

    if (id != null) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BusinessGeneral()));
    }
  }
}
