import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justicecorporate/ui/reused_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/images/handheld1.jpg',
      'title': 'Hand Helds',
      'description': 'Effortless Radiance',
    },
    {
      'image': 'assets/images/lamp1.jpg',
      'title': 'Reading Lamps',
      'description': 'Brillant Exhuberance',
    },
    {
      'image': 'assets/images/handheld2.jpg',
      'title': 'Security Torches',
      'description': 'Brillant Exhuberance',
    },
    {
      'image': 'assets/images/readinglamp1.jpg',
      'title': 'Bedside Lamps',
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
    Size screenSize = MediaQuery.of(context).size;
    final PageController _controller = PageController(
      viewportFraction: screenSize.width > 800 ? 0.5 : 1,
    );
    final PageController _controller1 = PageController();
    final PageController _controller2 = PageController(
      viewportFraction: screenSize.width > 800 ? 0.5 : 1,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              // Static row  for logo    vehicles, energy discover, charging, shop      support
              Header(screenSize: screenSize),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Torch Light',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      Column(
                        children: [
                          Container(
                            //  color: Colors.black.withOpacity(0.9),
                            height: 500,
                            child: PageView.builder(
                              padEnds: false,
                              pageSnapping: true,
                              controller: _controller,
                              itemCount: carouselItems.length,
                              itemBuilder: (context, index) {
                                final item = carouselItems[index];
                                return Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  width: screenSize.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(item['image']!),
                                    ),
                                  ),

                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 500,
                                          width: screenSize.width * 0.5,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            clipBehavior: Clip.hardEdge,
                                            // child: Image.asset(item['image']!),
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/torchlight',
                                                  );
                                                },
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
                                  ),
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
                              dotHeight: 10,
                              dotWidth: 10,
                              activeDotColor: Colors.black,
                              dotColor: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      //Solar Panels Text
                      Text(
                        'Solar Panels',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      //Solar Panels Column
                      Column(
                        children: [
                          Container(
                            //color: Colors.black.withOpacity(0.9),
                            height: 500,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            item['title'] ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 33,
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/torchlight',
                                                );
                                              },
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
                            controller: _controller1,
                            count: carouselItems2.length,
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
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            //  color: Colors.black.withOpacity(0.9),
                            height: 500,
                            child: PageView.builder(
                              padEnds: false,
                              controller: _controller2,
                              itemCount: carouselItems3.length,
                              itemBuilder: (context, index) {
                                final item = carouselItems3[index];
                                return Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  width: screenSize.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(item['image']!),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/torchlight',
                                                  );
                                                },
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
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),

                          //page indicator
                          SmoothPageIndicator(
                            controller: _controller2,
                            count: carouselItems3.length,
                            effect: WormEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Colors.black,
                              dotColor: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
