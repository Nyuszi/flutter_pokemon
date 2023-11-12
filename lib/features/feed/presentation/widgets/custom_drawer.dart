import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onApiPressed;

  const CustomDrawer({super.key, required this.onApiPressed});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red.shade800,
      child: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: const Text('PokeApi Documentation'),
            onTap: () {
              onApiPressed();
            },
          ),
        ],
      ),
    );
  }
}
