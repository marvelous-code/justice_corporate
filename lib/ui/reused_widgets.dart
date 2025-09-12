import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.screenSize});

  final Size screenSize;

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

          screenSize.width < 900
              ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/menu');
                },
                icon: Icon(Icons.menu),
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
                        Navigator.pushNamed(context, '/aboutus');
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
