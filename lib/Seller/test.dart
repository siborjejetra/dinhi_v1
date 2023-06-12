import 'package:flutter/material.dart';

class MyRadioListWidget extends StatefulWidget {
  @override
  _MyRadioListWidgetState createState() => _MyRadioListWidgetState();
}

class _MyRadioListWidgetState extends State<MyRadioListWidget> {
  int _selectedOption = -1;
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(options[index]),
                  value: index,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as int;
                    });
                  },
                  activeColor:
                      Colors.green, // Change the active (selected) color
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
