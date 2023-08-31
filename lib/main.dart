import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database.dart';
import 'singuppage.dart ';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: SplashScreen(),
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
    super.initState();
    Timer(Duration(seconds: 6), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/profJMC.jpg'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FragmentOne(),
    FragmentTwo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[400],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Home Screen',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person_off),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FragmentOne extends StatelessWidget {

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https",host:url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    ));
    {
      throw "can not launch url";
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Stateless Screen'),
      ),
      body:  Center(
        child: GestureDetector(

          onTap: (){
            _launchURL("www.google.com");
          },


        ),

      ),
    );
  }
}

class FragmentTwo extends StatefulWidget {
  @override
  _FragmentTwoState createState() => _FragmentTwoState();
}

class _FragmentTwoState extends State<FragmentTwo> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    final userData = await _databaseHelper.getCurrentUser();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        TextField(
        decoration: InputDecoration(
        labelText: 'Email: ${_userData['email'] ?? ''}',
          enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0)))
            ,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
        )),
        TextField(
            decoration: InputDecoration(
              labelText: 'Password: ${_userData['password'] ?? ''}',
              enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0)))
              ,
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
            )),
            TextField(
                decoration: InputDecoration(
                  labelText: 'Course: ${_userData['course'] ?? ''}',
                  enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0)))
                  ,
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
                )),


          ],
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController2 = TextEditingController();
  final _passwordController2 = TextEditingController();
  final _courseController2 = TextEditingController();


  bool _isStudent = false;









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //DropdownButtonFormField(
                //decoration: const InputDecoration(
                  //labelText: 'Category',
                  //border: OutlineInputBorder(),
                //),
                //value: _isStudent ? 'student' : 'non-student',
                //items:const  [
                  // DropdownMenuItem(
                    //value: 'student',
                    //child: Text('Student'),
                  //),
                  //DropdownMenuItem(
                    //value: 'non-student',
                    //child: Text('Faculty / Non-teaching Staff'),
                  //),
                //],
                //onChanged: (value) {
                  //setState(() {
                    //_isStudent = value == 'student';
                  //});
                //},
              //),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _emailController2,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController2,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: _isStudent ? 20.0 : 0),


              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: ()  {


                  void _login(String email, String password) async {
                    // Replace this logic with your actual email and password checking code
                    if (await DatabaseHelper.instance.login2(email, password) ) {
                      // Login successful
                      Navigator.push(context,
                          MaterialPageRoute(builder:(_)=> MyHomePage()));
                    } else {
                      // Invalid credentials
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid password or email')),
                      );
                    }
                  }

                  String email = _emailController2.text;
                  String password = _passwordController2.text;
                  _login(email, password);
                },
                child: Text('Login'),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Does not have acount?"),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder:(_)=> SignupForm()));





                      } ,
                      child: Text('Signup'),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
