import 'package:flutter/material.dart';
import 'main.dart';
import 'database.dart';

class SignupForm extends StatefulWidget{

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final List<String> options = ['Maths', 'English', 'Science', 'Faculty'];
  String? selectedOption;


  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _courseController = TextEditingController();
  late DatabaseHelper _databaseHelper;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('login with signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.0),
              Text('login',
              style: TextStyle(

                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 40.0),
              ),


              SizedBox(height: 10.0,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 10.0),
                child: DropdownButtonFormField<String>(


                  value: selectedOption,
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value)  {
                    setState(() {
                      selectedOption = value;
                      _courseController.text = value ?? '';
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select an option',
                    border: OutlineInputBorder(),
                  ),
                ),


              ),






              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: _emailController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'User Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'create account',
                    style: TextStyle(color: Colors.amber),
                  ),
                  onPressed: () async{
                    Navigator.push(context,
                        MaterialPageRoute(builder:(_)=> LoginScreen()));



                      if (_formKey.currentState!.validate()) {


                        final Map<String, dynamic> data = {
                          'email': _emailController.text,
                          'password': _passwordController.text,
                          'course': _courseController.text,
                        };

                        await DatabaseHelper.instance.insertData(data);




                        // await _databaseHelper.insertUser(data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User saved to database')),
                        );
                        final List<Map<String, dynamic>> data1 = await DatabaseHelper.instance.getAllData();
                        data1.forEach((row) {
                          print('ID: ${row['id']}');
                          print('Email: ${row['email']}');
                          print('Password: ${row['password']}');
                          print('Course: ${row['course']}');
                          print('---------------------------');
                        });




                      }






                  },
                ),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),




            ],
          ),
        ),
      ),
    );
}
}