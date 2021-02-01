import 'package:amal_firebase/backend/server.dart';
import 'package:amal_firebase/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MaterialApp(
        home: App(),
        // theme: ThemeData(
        //     textTheme: TextTheme(
        //       body1: profileStyle.copyWith(fontWeight: FontWeight.w700),
        //     )),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return SplashScreen();
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  String email;
  String password;
  String name;
  String phoneNumber;
  String address;


  saveEmail(String email) {
    this.email = email;
  }

  savePassword(String password) {
    this.password = password;
  }

  saveAddress(String address) {
    this.address = address;
  }

  saveName(String name) {
    this.name = name;
  }

  savePhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  nullValidation(String value) {
    if (value == '') {
      return 'needed field';
    }
  }

  saveForm(){
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      saveUser({
          'email':this.email,
          'password':this.password,
          'name':this.name,
          'phoneNumber':this.phoneNumber,
          'address':this.address,
        });
    }else{
      return ;
    }
  }
GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'HOME PAGE',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.lightGreen),
                  ),
                ),
                CustomTextField(
                  saveFun: saveEmail,
                  lableText: 'EMAIL',
                  validationFun: nullValidation,

                ),
                CustomTextField(
                  saveFun:savePassword,
                  lableText: 'PASSWORD',
                  validationFun:nullValidation,

                ),
                CustomTextField(
                  saveFun:saveName,
                  lableText: 'NAME',
                  validationFun:nullValidation,

                ),
                CustomTextField(
                  saveFun:savePhoneNumber,
                  lableText: 'PHONE',
                  validationFun:nullValidation,

                ),
                CustomTextField(
                  saveFun:saveAddress,
                  lableText: 'ADDRESS',
                  validationFun:nullValidation,

                ),
                // TextField(
                //   decoration: InputDecoration(labelText: 'EMAIL'),
                //   onChanged: (val) {
                //     this.email = val;
                //   },
                // ),
                // SizedBox(height: 15,),
                // TextField(
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12)
                //       ),
                //       labelText: 'PASSWORD'),
                //   onChanged: (val) {
                //     this.password = val;
                //   },
                // ),

                RaisedButton(
                    child: Text('REGISTER'),
                    onPressed: () async {
                      saveForm();
                     //  String id = await registerByEmailPassword(email, password);
                     // print(id);
                     //  if (id != null) {
                     //    Navigator.pushReplacement(context,
                     //        MaterialPageRoute(builder: (context) {
                     //          return MainPage();
                     //        }));
                     //  } else {}
                    }),
                RaisedButton(
                    child: Text('LOGIN'),
                    onPressed: () async {
                      // String id = await loginByEmailPassword(email, password);
                      // print(id);
                      // if (id != null) {
                      //   Navigator.pushReplacement(context,
                      //       MaterialPageRoute(builder: (context) {
                      //         return MainPage();
                      //       }));
                      // } else {
                      //   print('error');
                      // }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: InkWell(
            onTap: () {
              singOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
            },
            child: Icon(Icons.logout)),
      ),
      body: Center(
        child: Text(
          'YOU ARE AUTHORED USER',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(
      seconds: 3,
    )).then((value) {
      if (getUserId() != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return MainPage();
            }));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
