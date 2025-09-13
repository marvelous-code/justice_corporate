import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.screenSize});

  final Size screenSize;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'JUSTICE CORPORATE MARKETING LIMITED',
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          widget.screenSize.width < 900
              ? MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          _isHovered
                              ? Colors.grey.shade400
                              : Colors.grey.shade200,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
              : Expanded(
                flex: 2,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Home',
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/torchlight');
                      },
                      child: Text(
                        'Torch Light',
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/solarpanels');
                      },
                      child: Text(
                        'Solar Panels',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/recharge');
                      },
                      child: Text(
                        'Rechargeable Fans',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/batteries');
                      },
                      child: Text(
                        'Batteries',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/aboutus');
                      },
                      child: Text(
                        'About Us',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
