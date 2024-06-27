import 'package:flutter/material.dart';

Widget buildTextField({
  required String labelText,
  required TextEditingController controller,
  required bool isValid,
  required ValueChanged<String> onChanged,
}) {
  return TextField(
    controller: controller,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: labelText,
      errorText: isValid ? null : '$labelText cannot be empty',
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
      ),
    ),
  );
}

Widget buildFieldLabel(String label) {
  return Text(
    label,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}
