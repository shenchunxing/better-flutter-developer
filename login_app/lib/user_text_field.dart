import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? placeholder;
  final bool usedInPassword;
  final Widget? suffixWidget;
  final int? maxLength;

  const UserTextField({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.placeholder,
    this.usedInPassword = false,
    this.suffixWidget,
    this.maxLength,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  var _showClearIcon = false;
  var _showEyeIcon = false;
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _obscurePassword = widget.usedInPassword;

    widget.controller.addListener(() {
      var isNotEmpty = widget.controller.text.isNotEmpty;
      setState(() {
        _showEyeIcon = isNotEmpty;
        _showClearIcon = isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: (_) {},
      placeholder: widget.placeholder,
      style: const TextStyle(color: Colors.black),
      placeholderStyle: const TextStyle(color: Colors.grey),
      maxLength: widget.maxLength,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(26),
      ),
      obscureText: _obscurePassword,
      obscuringCharacter: "*",
      suffix: widget.suffixWidget ??
          (widget.usedInPassword ? _buildPasswordEyeIcon() : _buildClearIcon()),
    );
  }

  Widget _buildClearIcon() {
    return _showClearIcon
        ? CupertinoButton(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: const Icon(Icons.clear, size: 18),
      onPressed: () => widget.controller.clear(),
    )
        : const SizedBox(width: 8.0);
  }

  Widget _buildPasswordEyeIcon() {
    return _showEyeIcon
        ? CupertinoButton(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Icon(
        _obscurePassword ? Icons.visibility_off : Icons.visibility,
        size: 18,
      ),
      onPressed: () {
        setState(() => _obscurePassword = !_obscurePassword);
      },
    )
        : const SizedBox(width: 8.0);
  }
}


