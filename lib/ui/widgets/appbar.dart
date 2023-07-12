import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      foregroundColor: Colors.black,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF554AF0),
          ),
          onPressed: () => Navigator.pop(context)));
}
