import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Torchlight extends StatefulWidget {
  const Torchlight({super.key});

  @override
  State<Torchlight> createState() => _TorchlightState();
}

class _TorchlightState extends State<Torchlight> {
  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/fan1.jpg',
      'name': 'Rechargeable Fan',
      'price': '\$45',
    },
    {'image': 'assets/images/fan2.jpg', 'name': 'Torch Light', 'price': '\$15'},
    {'image': 'assets/images/fan1.jpg', 'name': 'Solar Lamp', 'price': '\$25'},
    {'image': 'assets/images/fan2.jpg', 'name': 'Power Bank', 'price': '\$30'},
    {
      'image': 'assets/images/fan1.jpg',
      'name': 'Battery Pack',
      'price': '\$18',
    },
    {
      'image': 'assets/images/fan1.jpg',
      'name': 'Standing Fan',
      'price': '\$60',
    },
    {
      'image': 'assets/images/fan1.jpg',
      'name': 'Ceiling Lamp',
      'price': '\$50',
    },
    {'image': 'assets/images/fan1.jpg', 'name': 'Desk Light', 'price': '\$22'},
    {'image': 'assets/images/fan1.jpg', 'name': 'Mini Fan', 'price': '\$12'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top bar
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

          // Body with inventory + divider + grid
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(children: const [Text('INVENTORY')]),
                ),
                Container(
                  height: double.infinity,
                  color: Colors.black,
                  width: 2,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 columns
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  product['image']!,
                                  fit: BoxFit.cover,
                                  height: 300,
                                  width: 300,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 6.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product['name']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product['price']!,
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
