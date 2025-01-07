import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class CustomTextInput extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool isObscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  const CustomTextInput({
    super.key,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText ?? hintText,
        fillColor: Palette.inputBackground,
        filled: true,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 30, // Thụt vào hai bên
          vertical: 16, // Khoảng cách trên/dưới
        ),
      ),
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}

// class CustomDropDownList extends StatelessWidget {
//   final List<Map<String, String>> list;
//   final String selectedValue;
//   const CustomDropDownList(
//       {super.key, required this.list, required this.selectedValue});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class CustomDropDownList extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final List<Map<String, String>> list;
  final ValueChanged<String> onChanged;
  String? selectedValue;
  CustomDropDownList({
    super.key,
    required this.hintText,
    this.labelText,
    required this.list,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  State<CustomDropDownList> createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    borderRadius: BorderRadius.circular(12.0),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7F8FA), // Nền giống TextFormField
        borderRadius: BorderRadius.circular(12.0), // Bo góc
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Color(0xFFF7F8FA),
          filled: true,
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 16,
          ),
        ),
        value: widget.selectedValue,
        items: widget.list.map((role) {
          return DropdownMenuItem<String>(
            value: role['value'],
            child: Text(role['label'].toString()),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (value != null) {
              widget.onChanged(value); 
            }
          });
        },
      ),
    );
  }
}
