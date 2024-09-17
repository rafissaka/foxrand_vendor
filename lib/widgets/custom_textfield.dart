import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintext;
  bool isPassword;
  final bool isEmail;
  final bool isName;
  final bool isMobile;
  final TextInputType type;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintext,
    required this.isPassword,
    required this.isEmail,
    required this.isName,
    required this.isMobile,
    required this.type,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  void _toggle() {
    setState(() {
      widget.isPassword = !widget.isPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      validator: (value) {
        if (widget.isEmail == true) {
          if (value!.isEmpty) {
            return ("Please enter email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter a valid email");
          }
        }

        if (widget.isPassword == true) {
          if (value!.isEmpty) {
            return ("Please enter password");
          }
          RegExp regex = RegExp(r'^.{6,}$');
          if (!regex.hasMatch(value)) {
            return ("Please Enter Valid Password(Min. 6 characters)");
          }
        }
        if (widget.isName == true) {
          if (value!.isEmpty) {
            return ("Please enter Name");
          }
        }
        if (widget.isMobile == true) {
          if (value!.isEmpty) {
            return ("Please enter contact");
          }
          RegExp regex = RegExp(
              r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');
          if (!regex.hasMatch(value)) {
            return ("Please enter valid number format)");
          }
        }
        return null;
      },
      textInputAction:
          widget.isPassword ? TextInputAction.done : TextInputAction.next,
      keyboardType: widget.type,
      onSaved: (value) {
        widget.controller.text = value.toString();
      },
      cursorColor: Colors.transparent,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword == true
            ? GestureDetector(
                onTap: _toggle,
                child: Icon(
                  widget.isPassword ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : null,
        prefixIcon: Icon(
          widget.icon,
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xfffe724c))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red)),
        label: Text(widget.hintext),
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}
