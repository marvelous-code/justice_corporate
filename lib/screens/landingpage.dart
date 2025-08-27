import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  final PageController _controller = PageController(
    viewportFraction: 0.4,
    initialPage: 2,
  );
  final PageController _controller1 = PageController();
  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/images/handheld1.jpg',
      'title': 'Reading Lamps',
      'description': 'Effortless Radiance',
    },
    {
      'image': 'assets/images/lamp1.jpg',
      'title': 'Hand helds',
      'description': 'Brillant Exhuberance',
    },
    {
      'image': 'assets/images/handheld2.jpg',
      'title': 'Hand helds',
      'description': 'Brillant Exhuberance',
    },
    {
      'image': 'assets/images/readinglamp1.jpg',
      'title': 'Hand helds',
      'description': 'Brillant Exhuberance',
    },
  ];
  final List<Map<String, String>> carouselItems2 = [
    {
      'image': 'assets/images/solarpanel1.jpg',
      'title': 'Home Panels',
      'description': 'Executed  to Perfection',
    },
    {
      'image': 'assets/images/solarpanel2.jpg',
      'title': 'Industrial Panels',
      'description': 'Brillant Exhuberance',
    },
  ];
  final List<Map<String, String>> carouselItems3 = [
    {
      'image': 'assets/images/fan1.jpg',
      'title': 'Standing Fans',
      'description': 'Executed  to Perfection',
    },
    {
      'image': 'assets/images/fan4.jpg',
      'title': 'Mist Fans',
      'description': 'Brillant Exhuberance',
    },
    {
      'image': 'assets/images/fan5.jpg',
      'title': 'Hand helds',
      'description': 'Brillant Exhuberance',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            // Static row  for logo    vehicles, energy discover, charging, shop      support
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
                          child: Text(
                            'Solar Panels',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Rechargeable Fans',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Touch Light',
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                    Column(
                      children: [
                        Container(
                          //  color: Colors.black.withOpacity(0.9),
                          height: 550,
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: carouselItems.length,
                            itemBuilder: (context, index) {
                              final item = carouselItems[index];
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 500,
                                      width: 500,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.asset(item['image']!),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          item['title'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item['description'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Euclid',
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          height: 45,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'View Inventory',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),

                        //page indicator
                        SmoothPageIndicator(
                          controller: _controller,
                          count: carouselItems.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Solar Panels',
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                    Column(
                      children: [
                        Container(
                          //color: Colors.black.withOpacity(0.9),
                          height: 550,
                          child: PageView.builder(
                            controller: _controller1,
                            itemCount: carouselItems2.length,
                            itemBuilder: (context, index) {
                              final item = carouselItems2[index];
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 500,
                                      width: double.infinity,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.asset(item['image']!),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          item['title'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item['description'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Euclid',
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          height: 45,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'View Inventory',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 50),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),

                        //page indicator
                        SmoothPageIndicator(
                          controller: _controller,
                          count: carouselItems.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rechargeable Fans',
                      style: TextStyle(fontSize: 32, color: Colors.black),
                    ),
                    Column(
                      children: [
                        Container(
                          //  color: Colors.black.withOpacity(0.9),
                          height: 550,
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: carouselItems3.length,
                            itemBuilder: (context, index) {
                              final item = carouselItems3[index];
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 500,
                                      width: 500,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.asset(item['image']!),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          item['title'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item['description'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Euclid',
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          height: 45,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'View Inventory',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),

                        //page indicator
                        SmoothPageIndicator(
                          controller: _controller,
                          count: carouselItems.length,
                          effect: WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.black,
                            dotColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
