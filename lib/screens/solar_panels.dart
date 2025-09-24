import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:justicecorporate/functions/upload_function.dart';
import 'package:justicecorporate/ui/reused_widgets.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SolarPanels extends StatefulWidget {
  const SolarPanels({super.key});

  @override
  State<SolarPanels> createState() => _SolarPanelsState();
}

class _SolarPanelsState extends State<SolarPanels> {
  final TextEditingController _controller = TextEditingController();
  List<String> _solarpanelBrands = [];
  bool isClicked = false;
  bool isHovered = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      // Build the product map
      Map<String, dynamic> productData = {
        "productName": _productNameController.text.trim(),
        "unitsInCarton": _unitsController.text.trim(),
        "availability": _availabilityController.text.trim(),
      };

      try {
        // ✅ Call your upload function
        await uploadImageWithData('Solar Panels', selectedOption!, productData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Product uploaded with image")),
        );

        // Clear inputs after upload
        _productNameController.clear();
        _unitsController.clear();
        _availabilityController.clear();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ Upload failed: $e")));
      }
    }
  }

  void _addItem() async {
    final text = _controller.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        _solarpanelBrands.add(text); // ✅ local update
        _controller.clear();
      });

      try {
        // Save the whole list to Firestore (you could also push only the new item)
        await FirebaseFirestore.instance
            .collection("solarpanelBrands")
            .doc("brandsList") // using a fixed doc ID
            .set({"brands": _solarpanelBrands});

        print("✅ List updated in Firestore");
      } catch (e) {
        print("❌ Failed to upload list: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBrandsFromFirestore();
  }

  Future<void> _loadBrandsFromFirestore() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection("solarpanelBrands")
              .doc("brandsList")
              .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data["brands"] is List) {
          setState(() {
            _solarpanelBrands = List<String>.from(data["brands"]);
            selectedOption = _solarpanelBrands[0];
          });
        }
      }
    } catch (e) {
      print("❌ Failed to load brands: $e");
    }
  }

  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header Widget
            Header(screenSize: screenSize),
            //Page Title
            Text(
              'Solar Panel Kits',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
            ),

            // Body with inventory + divider + grid
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (screenSize.width > 800)
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1000,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MouseRegion(
                                  onEnter: (_) {
                                    setState(() {
                                      isHovered = !isHovered;
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      isHovered = !isHovered;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isClicked = !isClicked;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isHovered
                                                ? Colors.grey.shade400
                                                : Colors.transparent,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      duration: Duration(milliseconds: 400),

                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            selectedOption ??
                                                'Solar Panel Brands',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(width: 100),
                                          Transform.rotate(
                                            angle:
                                                isClicked
                                                    ? math.pi / 2
                                                    : math.pi * 1.5,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 3),
                                if (isClicked)
                                  SizedBox(
                                    height: 300,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _solarpanelBrands.length,
                                      itemBuilder: (context, index) {
                                        final torchBrand =
                                            _solarpanelBrands[index];
                                        return ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(torchBrand),
                                          leading: Radio<String>(
                                            fillColor: WidgetStateProperty.all(
                                              Colors.black,
                                            ),
                                            value: torchBrand,
                                            groupValue: selectedOption,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedOption = value;
                                              });
                                            },
                                          ),
                                          onTap: () {
                                            setState(() {
                                              selectedOption = torchBrand;
                                              print(selectedOption);
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),

                                //PASTE HERE
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (screenSize.width > 800)
                    Divider(thickness: 1, height: double.maxFinite),
                  Container(
                    height: double.infinity,
                    color: Colors.black,
                    width: 2,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        if (screenSize.width < 800)
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                isHovered = !isHovered;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                isHovered = !isHovered;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isClicked = !isClicked;
                                });
                              },
                              child: AnimatedContainer(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isHovered
                                          ? Colors.grey.shade400
                                          : Colors.transparent,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                duration: Duration(milliseconds: 400),

                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      selectedOption ?? 'SolarPanel Brands',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 100),
                                    Transform.rotate(
                                      angle:
                                          isClicked
                                              ? math.pi / 2
                                              : math.pi * 1.5,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        if (screenSize.width < 800 && isClicked)
                          Expanded(
                            // 👈 give inventory scrollable space
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 3),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        NeverScrollableScrollPhysics(), // 👈 avoid nested scrolls
                                    itemCount: _solarpanelBrands.length,
                                    itemBuilder: (context, index) {
                                      final torchBrand =
                                          _solarpanelBrands[index];
                                      return ListTile(
                                        title: Text(torchBrand),
                                        leading: Radio<String>(
                                          fillColor: WidgetStateProperty.all(
                                            Colors.black,
                                          ),
                                          value: torchBrand,
                                          groupValue: selectedOption,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value;
                                            });
                                          },
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedOption = torchBrand;
                                            print(selectedOption);
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  // input + add button
                                  if (!kIsWeb)
                                    Column(
                                      children: [
                                        TextField(
                                          controller: _controller,
                                          decoration: InputDecoration(
                                            labelText: "Enter brand",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: _addItem,
                                          child: const Text(
                                            "Add TorchLight Brand",
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      _productNameController,
                                                  decoration: InputDecoration(
                                                    labelText: "Product Name",
                                                  ),
                                                  validator:
                                                      (value) =>
                                                          value == null ||
                                                                  value.isEmpty
                                                              ? "Enter product name"
                                                              : null,
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  controller: _unitsController,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "No. of Units in Carton",
                                                  ),
                                                  validator:
                                                      (value) =>
                                                          value == null ||
                                                                  value.isEmpty
                                                              ? "Enter units"
                                                              : null,
                                                ),
                                                const SizedBox(height: 10),
                                                TextFormField(
                                                  controller:
                                                      _availabilityController,
                                                  decoration: InputDecoration(
                                                    labelText: "Availability",
                                                  ),
                                                  validator:
                                                      (value) =>
                                                          value == null ||
                                                                  value.isEmpty
                                                              ? "Enter availability"
                                                              : null,
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: _addProduct,
                                                  child: const Text(
                                                    "Add Product",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  // form
                                ],
                              ),
                            ),
                          ),

                        // ✅ Products Grid takes remaining space
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child:
                                selectedOption == null
                                    ? const Center(
                                      child: Text('Please select torch brand'),
                                    )
                                    : ProductsGrid(
                                      selectedOption: selectedOption!,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final String selectedOption;

  const ProductsGrid({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(selectedOption).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No products uploaded yet"));
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenSize.width > 800 ? 3 : 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            //childAspectRatio: 0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index].data() as Map<String, dynamic>;

            // Decode base64 back to image
            Uint8List? imageBytes;
            if (product['imageBase64'] != null) {
              imageBytes = base64Decode(product['imageBase64']);
            }

            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child:
                          imageBytes != null
                              ? Image.memory(
                                imageBytes,
                                fit: BoxFit.contain,

                                width: double.maxFinite,
                              )
                              : const Icon(Icons.image_not_supported, size: 80),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 6.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['productName'] ?? 'Unnamed',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${product['price'] ?? '0'}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          product['availability'],
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class HoverableClickableTile extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const HoverableClickableTile({Key? key, required this.label, this.onTap})
    : super(key: key);

  @override
  _HoverableClickableTileState createState() => _HoverableClickableTileState();
}

class _HoverableClickableTileState extends State<HoverableClickableTile> {
  bool isHovered = false;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isClicked = !isClicked;
          });
          if (widget.onTap != null) widget.onTap!();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: isHovered ? Colors.grey.shade400 : Colors.transparent,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 100),
              Transform.rotate(
                angle: isClicked ? math.pi / 2 : math.pi * 1.5,
                child: const Icon(Icons.arrow_back_ios, size: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
