import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({Key key, this.onChanged});
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            ),
            hintText: 'Enter a search term'),
        onChanged: onChanged);
  }
}
