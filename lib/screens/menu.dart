import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, '/menu');
            },
            icon: Icon(Icons.cancel),
          ),
          SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/torchlight');
            },
            child: Text('Torch Light'),
          ),
        ],
      ),
    );
  }
}
