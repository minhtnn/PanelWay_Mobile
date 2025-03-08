import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';

class CustomTextInput extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final bool? hasValue;
  final TextEditingController? controller;
  final bool isObscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool needExtendHeight;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const CustomTextInput({
    super.key,
    this.labelText,
    required this.hintText,
    this.hasValue,
    required this.controller,
    this.isObscureText = false,
    this.readOnly = false,
    this.onTap,
    this.needExtendHeight = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  late bool isObscure;
  late bool showIcon;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscureText; // Initialize hidden/visible state
    // Show icon if controller already has text
    showIcon = widget.controller != null && widget.controller!.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hasValue ?? false)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.labelText ?? widget.hintText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: (value) {
            setState(() {
              showIcon = value.isNotEmpty;
            });
            
            // Call external onChanged if provided
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          decoration: InputDecoration(
            hintText: (widget.hasValue ?? false) ? null : widget.hintText,
            labelText: (widget.hasValue ?? false) ? null : widget.labelText ?? widget.hintText,
            fillColor: Palette.inputBackground,
            filled: true,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Palette.blueButton, width: 1.0),
            ),
            errorBorder: outlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: outlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 30, // Indent on both sides
              vertical: 16, // Top/bottom spacing
            ),
            // Only show icon when input has text and is a password field
            suffixIcon: (widget.isObscureText && showIcon)
                ? IconButton(
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure; // Toggle state
                      });
                    },
                  )
                : showIcon && !widget.isObscureText
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          widget.controller?.clear();
                          setState(() {
                            showIcon = false;
                          });
                          // Call external onChanged if provided
                          if (widget.onChanged != null) {
                            widget.onChanged!('');
                          }
                        },
                      )
                    : null,
          ),
          validator: widget.validator ?? (val) {
            if (val == null || val.trim().isEmpty) {
              return "${widget.hintText} is required!";
            }
            return null;
          },
          obscureText: isObscure,
          minLines: 1,
          maxLines: widget.needExtendHeight ? null : 1,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}


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
        isExpanded: true,
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
