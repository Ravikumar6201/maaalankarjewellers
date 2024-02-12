import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyBoard extends StatefulWidget {
  @override
  _CopyBoardState createState() => _CopyBoardState();
}

class _CopyBoardState extends State<CopyBoard> {
  String selectedOption = 'Option 1';

  List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select and Copy Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DropdownButton for selecting options
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // GestureDetector to handle tap event and copy text
            GestureDetector(
              onTap: () {
                // Use Clipboard to copy text to the clipboard
                Clipboard.setData(ClipboardData(text: selectedOption));

                // Show a snackbar to indicate that the text is copied
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied: $selectedOption'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Text(
                  'Copy Text',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
