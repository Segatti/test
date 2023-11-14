import 'package:flutter/material.dart';

class AuthFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool haveError;
  final bool isObscureText;
  final Widget icon;
  final VoidCallback validateForm;
  const AuthFieldWidget({
    super.key,
    required this.controller,
    required this.haveError,
    required this.validateForm,
    required this.isObscureText,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // alphanumeric with space inside
    final validCharacters = RegExp(r'^[a-zA-Z0-9\s]+$');

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 20,
          obscureText: isObscureText,
          cursorColor: Colors.black,
          onChanged: (_) => (haveError) ? validateForm() : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Preencha este campo';
            } else if (value.endsWith(" ")) {
              return 'Não pode terminar com espaço';
            }
            if (isObscureText) {
              if (value.length < 2) {
                return 'Senha deve ter 2 ou mais caracteres';
              } else if (!validCharacters.hasMatch(value)) {
                return 'Não é permitido caracter especial';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            counterText: "",
            errorStyle: const TextStyle(
              color: Colors.yellow,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.only(
              left: 16.0,
              bottom: 8.0,
              top: 8.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
            prefixIcon: icon,
          ),
        ),
      ],
    );
  }
}
