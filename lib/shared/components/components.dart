import 'package:flutter/material.dart';

void navigateTo({required context, required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultTextFromField({
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function()? suffixOnpressed,
  bool obscure = false,
  Function(String value)? functionOnFieldSubmitted,
  required TextEditingController controller,
  required TextInputType textInputType,
  required String? Function(String? value) validatorMethod,
}) =>
    TextFormField(
      controller: controller,
      obscureText: obscure,
      onFieldSubmitted: functionOnFieldSubmitted,
      keyboardType: textInputType,
      validator: validatorMethod,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixOnpressed,
        ),
      ),
    );

Widget defaultButton({
  required String text,
  double width = double.infinity,
  double radius = 3.0,
  Color background = Colors.blue,
  required Function() onPressed,
}) =>
    Container(
      height: 50.0,
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
