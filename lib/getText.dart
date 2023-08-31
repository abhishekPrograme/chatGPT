import"package:flutter/material.dart";

class getTextFormField extends StatelessWidget{
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObsecureText;

  getTextFormField({required this.controller,required this.hintName,required this.icon, this.isObsecureText=false}) ;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(top:10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.cyan),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          fillColor: Colors.brown,
          filled: true,
        ),
      ),
    );
  }
}