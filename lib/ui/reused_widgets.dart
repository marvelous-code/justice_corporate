import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final Size screenSize;

  const HeaderWidget({super.key, required this.screenSize});

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
          if (screenSize.width > 600)
            Expanded(
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
                    onPressed: () {},
                    child: const Text(
                      'Solar Panels',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Rechargeable Fans',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Batteries',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/aboutus');
                    },
                    child: const Text(
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
