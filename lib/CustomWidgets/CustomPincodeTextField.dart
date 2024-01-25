import 'package:flutter/material.dart';

class PinCodeTextField extends StatefulWidget {
  final int length;
  final Function(String) onSubmit;

  PinCodeTextField({required this.length, required this.onSubmit});

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  List<String> _pinCodes = [];

  void _onTextChanged(String value) {
    if (_pinCodes.length < widget.length) {
      setState(() {
        _pinCodes.add(value);
      });
      if (_pinCodes.length == widget.length) {
        widget.onSubmit(_pinCodes.join());
      }
    }
  }

  void _onDeletePressed() {
    if (_pinCodes.length > 0) {
      setState(() {
        _pinCodes.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.length, (index) {
          return SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 24),
            ),
          );
        })
          ..add(SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Icon(Icons.backspace),
              onPressed: _onDeletePressed,
            ),
          )),
      ),
    );
  }
}
