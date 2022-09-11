import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

void showToast({
  required String message,
  required ToastState color,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(color),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCESS, EROERR, WARNING }

Color chooseColor(ToastState choose) {
  Color color;
  switch (choose) {
    case ToastState.SUCESS:
      color = Colors.green;
      break;
    case ToastState.EROERR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
