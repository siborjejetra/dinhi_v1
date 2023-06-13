import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio List Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Radio List Example'),
        ),
        body: MyRadioListWidget(),
      ),
    );
  }
}

class MyRadioListWidget extends StatefulWidget {
  @override
  _MyRadioListWidgetState createState() => _MyRadioListWidgetState();
}

class _MyRadioListWidgetState extends State<MyRadioListWidget> {
  int _selectedOption = -1;
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: RadioListTile(
                    title: Text(options[index]),
                    value: index,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value as int;
                      });
                    },
                    activeColor:
                        Colors.blue, // Set the active color as transparent
                    controlAffinity: ListTileControlAffinity
                        .trailing, // Move the radio button to the right side
                    toggleable: true, // Enable toggle functionality
                    secondary: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedOption == index
                              ? Colors.green
                              : Colors
                                  .grey, // Change the border color based on selection
                        ),
                      ),
                      child: _selectedOption == index
                          ? Icon(
                              Icons.check,
                              size: 16,
                              color: Colors
                                  .green, // Change the check icon color based on selection
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
