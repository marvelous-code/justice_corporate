import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'JUSTICE CORPORATE MARKETING LIMITED',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
          ),

          Column(
            children: [
              SizedBox(
                height: 300,
                child: Row(
                  children: [
                    Expanded(flex: 5, child: SizedBox(width: 10)),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.greenAccent,
                            ),
                            child: Text(
                              'About Justice Coporate Marketing Limited',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            'Experience the best in Electronics Excellence',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Justice Corporate Marketing Limited was incorporated in 2003 under the laws of the Federal Republic of Nigeria. The company operates as a nationwide distributor, providing top-quality products and services across the country. With a strong commitment to excellence, Justice Corporate Marketing Limited consistently delivers the best to its customers, earning a reputation for reliability and trust.',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Our Mission'),
                    ),
                    Text('Our Vision'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
