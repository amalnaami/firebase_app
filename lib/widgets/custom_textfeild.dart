import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function validationFun;
  Function saveFun;
  String lableText;

  CustomTextField({this.validationFun, this.saveFun, this.lableText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        TextFormField(
          onSaved: (value) {
            saveFun(value);
          },
          validator: (value) => validationFun(value),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelText: lableText),
        ),
      ],
    );
  }
}
