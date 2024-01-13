import 'package:flutter/material.dart';

class CustomTextFieldTitle extends StatefulWidget {
  CustomTextFieldTitle({
    Key? key,
    required this.controller,
    required this.fieldTitle,
    this.validator,
    this.hintText,
    this.onChanged,
    this.width,
    this.readOnly = false,
    this.focusColor = Colors.deepPurple,
    this.inputType,
  }) : super(key: key);

  final TextEditingController controller;
  final String fieldTitle;
  final String? Function(String?)? validator;
  final String? hintText;
  final double? width;
  final TextInputType? inputType;
  void Function(String)? onChanged;
  final bool readOnly;
  final Color? focusColor;

  @override
  State<CustomTextFieldTitle> createState() => _CustomTextFieldTitleState();
}

class _CustomTextFieldTitleState extends State<CustomTextFieldTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldTitle,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: widget.width,
          child: TextFormField(
            readOnly: widget.readOnly,
            obscureText: false,
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.inputType,
            decoration: InputDecoration(hintText: widget.hintText,
              contentPadding: const EdgeInsets.all(15),
              border: widget.readOnly
                  ? const UnderlineInputBorder()
                  : const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusColor: widget.focusColor, // Use the provided focusColor
            ),
          ),
        ),
      ],
    );
  }
}
