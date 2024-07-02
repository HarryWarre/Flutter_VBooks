import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool initialObscureText;

  const PasswordInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.initialObscureText = true,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.initialObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.labelText,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            textAlign: TextAlign.left,
            obscureText: isObscured,
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(
                color: Colors.teal,
              ),
              labelText: widget.hintText,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                ),
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
