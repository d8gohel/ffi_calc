

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';

import 'native_library.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '0';
  // ignore: non_constant_identifier_names
  String result_text='0';




  void _onButtonPressed(String value) {
    setState(() {
      if (_displayText == '0' ||_displayText== '0.0') {
        _displayText = value;
      } else {
        _displayText += value;
      }
      if(_displayText.endsWith('<')){
        _displayText=_displayText.substring(0,_displayText.length-2);
      }
      if(_displayText.contains('C')){
        _displayText= '0';
        result_text='0';
      }
      if(_displayText.endsWith('=')){
        _displayText= result_text;
      }
      final exp=_displayText;
        final expptr=exp.toNativeUtf8();
      try {
        

  if(_displayText.endsWith('=')){
    result_text=eval(expptr).toString();
    // print(result_text);
    
  }
  // print(_displayText);
  // print(eval(_displayText));
} finally {

  result_text=eval(expptr).toString();
    // print(result_text);
}
    });
  }

  Widget _buildButton(String text, {Color color = Colors.blue}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    _displayText,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    result_text,
                    style: const TextStyle(fontSize: 48, color: Colors.grey),
                  ),
                  
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white),
          _buildButtonRow(['C','%','<','/']),
          _buildButtonRow(['7', '8', '9', '*']),
          _buildButtonRow(['4', '5', '6', '-']),
          _buildButtonRow(['1', '2', '3', '+']),
          _buildButtonRow(['00', '0', '.','=' ]),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .map((text) => _buildButton(
                  text,
                  color: text == '=' ? Colors.orange : Colors.blue,
                ))
            .toList(),
      ),
    );
  }
}
