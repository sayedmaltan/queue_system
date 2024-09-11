import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0,
  required Function function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        height: 50,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(dynamic)? onSubmit,
  Function(dynamic)? onChange,
  Function? suffixPressed,
  Function? validate,
  Function? onTape,
  required String label,
  bool isPassword = false,
  double radius = 0,
  IconData? prefix,
  IconData? suffix,
}) =>
    TextFormField(
      onTap: () {
        onTape != null ? onTape() : null;
      },
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit != null ? (value) {onSubmit(value);} : null,
      onChanged: onChange != null ? (value) {onChange(value);}: null,
      validator: (value) {
       return validate !=null ? validate(value) : null ;
      },
      decoration: InputDecoration(
        labelText: label,

        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.teal,
            ),
          borderRadius: BorderRadius.circular(radius),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        prefixIcon: prefix != null
            ? Icon(
          prefix,
        )
            : null,
        suffixIcon: suffix != null
            ? InkWell(
          onTap: () {
            suffixPressed != null ? suffixPressed() : null;
          },
          child: Icon(
            suffix,
          ),
        )
            : null,
      ),
    );
