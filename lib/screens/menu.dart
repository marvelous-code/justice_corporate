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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, '/menu');
                },
                icon: Icon(Icons.cancel_outlined),
              ),
            ),
            SizedBox(height: 12),
            HoverMenuItem(title: 'Home', routeName: '/'),
            HoverMenuItem(title: 'TorchLight', routeName: '/torchlight'),
            HoverMenuItem(title: 'Solar Panels', routeName: '/solarpanels'),
            HoverMenuItem(title: 'Rechargeable Fans', routeName: '/recharge'),
            HoverMenuItem(title: 'Batteries', routeName: '/batteries'),
          ],
        ),
      ),
    );
  }
}

class HoverMenuItem extends StatefulWidget {
  final String title;
  final String routeName;

  const HoverMenuItem({
    super.key,
    required this.title,
    required this.routeName,
  });

  @override
  _HoverMenuItemState createState() => _HoverMenuItemState();
}

class _HoverMenuItemState extends State<HoverMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.routeName);
        },
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _isHovered ? Colors.grey.shade300 : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 15),
            ],
          ),
        ),
      ),
    );
  }
}
