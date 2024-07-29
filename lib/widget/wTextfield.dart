// ignore_for_file: file_names, overridden_fields, use_key_in_widget_constructors

import 'package:talaba_uz/utils/tools/file_important.dart';

class WidgetTextField extends StatelessWidget {
  const WidgetTextField({
    this.headText,
    this.hintText,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.suffixIconConstraints,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.key,
    this.prefixText,
    this.onSaved,
    this.errorText,
    this.keyboardType,
    this.onChanged,
    this.obscureText,
    this.onTap,
    this.readOnly,
    this.hintStyle,
  });
  final String? headText;
  final String? hintText;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? suffixIconConstraints;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  @override
  final Key? key;
  final String? prefixText;
  final void Function(String?)? onSaved;
  final String? errorText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final void Function()? onTap;
  final bool? readOnly;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width(context) * 0.09),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headText!,
            style: TextStyle(
              fontSize: 5 * devisePixel(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            readOnly: readOnly!,
            onTap: onTap,
            obscuringCharacter: "*",
            obscureText: obscureText!,
            key: key,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: TextStyle(
              fontSize: 5 * devisePixel(context),
              fontWeight: FontWeight.w500,
            ),
            onSaved: onSaved,
            decoration: InputDecoration(
              hintStyle: hintStyle,
              fillColor: Colors.white,
              filled: true,
              errorText: errorText,
              prefixText: prefixText,
              prefixStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 5 * devisePixel(context),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              hintText: hintText!,
              contentPadding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: 10,
              ),
              prefixIconConstraints: prefixIconConstraints,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              suffixIconConstraints: suffixIconConstraints,
            ),
          ),
        ],
      ),
    );
  }
}
