import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';

class NumericKeypad extends StatefulWidget {
  final TextEditingController controller;
  final Function()? onPress;
  final Function(String)? onNumberPressed;

  const NumericKeypad({super.key, required this.controller, this.onPress, this.onNumberPressed});

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  late TextEditingController _controller;
  bool isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
            ],
          ),
        ),
        Row(
          children: [
            _buildBiometricButton(),
            _buildButton('0'),
            _buildButton('⌫', onPressed: _backspace),
          ],
        ),
      ],
    );
  }

  Widget _buildBiometricButton() {
    return Expanded(
      child: IconButton(
        icon: const Icon(
          Icons.fingerprint,
          color: primaryColor,
          size: 30,
        ),
        onPressed: widget.onPress,
      ),
    );
  }

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return Expanded(
      child: TextButton(
          onPressed: onPressed ?? () => _input(text),
          isSemanticButton: false,
          child: Text(text,style: const TextStyle(
              color: primaryColor,
              fontSize: 16
          ),)
      ),
    );
  }

  void _input(String text) {
    final value = _controller.text + text;
    _controller.text = value;

    // Notifier le parent qu'un chiffre a été pressé
    if (widget.onNumberPressed != null) {
      widget.onNumberPressed!(text);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
      });
    });
  }

  void _backspace() {
    final value = _controller.text;
    if (value.isNotEmpty) {
      _controller.text = value.substring(0, value.length - 1);

      // Notifier le parent qu'un backspace a été pressé
      if (widget.onNumberPressed != null) {
        widget.onNumberPressed!('⌫');
      }
    }
  }
}
