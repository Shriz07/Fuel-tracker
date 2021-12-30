import 'package:flutter/material.dart';

DecorationImage CustomDecorationImage(isDarkTheme) {
  if (isDarkTheme == true) {
    return DecorationImage(
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop,
      ),
      image: AssetImage('assets/images/login-background.png'),
      fit: BoxFit.cover,
    );
  } else {
    return DecorationImage(
      image: AssetImage('assets/images/login-background.png'),
      fit: BoxFit.cover,
    );
  }
}

Widget authenticationFormField(TextEditingController controller, FormFieldValidator<String> validator, String hintText, Icon icon, bool obscure) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: obscure,
    decoration: InputDecoration(
      errorStyle: TextStyle(color: Colors.yellow, fontSize: 15),
      filled: true,
      hintText: hintText,
      prefixIcon: icon,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget textLink(String text, String referenceText, VoidCallback? navigateToScreen) {
  return Material(
    color: Colors.grey.withOpacity(0.8),
    elevation: 10,
    shadowColor: Colors.grey,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        SizedBox(width: 5),
        TextButton(
          onPressed: navigateToScreen,
          child: Text(
            referenceText,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          ),
        )
      ],
    ),
  );
}
