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

  CustomTextInput({
    super.key,
    this.labelText,
    required this.hintText,
    this.hasValue,
    required this.controller,
    this.isObscureText = false,
    this.readOnly = false,
    this.onTap,
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
    isObscure = widget.isObscureText; // Khởi tạo trạng thái ẩn/hiện
    showIcon = false; // Khởi tạo trạng thái không hiển thị icon
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    return Column(
      children: [
        (widget.hasValue??false)?
        Container(
          alignment: Alignment.topLeft,
          padding:const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.labelText ?? widget.hintText,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ): SizedBox(),
        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          onChanged: (value) {
            setState(() {
              showIcon = value.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: (widget.hasValue?? false) ? null : widget.hintText,
            labelText: (widget.hasValue??false)? null : widget.labelText ?? widget.hintText,
            fillColor: Palette.inputBackground,
            filled: true,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 30, // Thụt vào hai bên
              vertical: 16, // Khoảng cách trên/dưới
            ),
            // Chỉ hiển thị biểu tượng khi người dùng nhập
            suffixIcon: (widget.isObscureText && showIcon)
                ? IconButton(
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure; // Thay đổi trạng thái
                      });
                    },
                  )
                : null,
          ),
          validator: (val) {
            if (val!.trim().isEmpty) {
              return "${widget.hintText} is missing!";
            }
            return null;
          },
          obscureText: isObscure,
        ),
      ],
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
