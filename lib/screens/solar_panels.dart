import 'package:flutter/material.dart';

import 'package:justicecorporate/functions/upload_function.dart';
import 'package:justicecorporate/ui/reused_widgets.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SolarPanels extends StatefulWidget {
  const SolarPanels({super.key});

  @override
  State<SolarPanels> createState() => _SolarPanelsState();
}

class _SolarPanelsState extends State<SolarPanels> {
  final TextEditingController _controller = TextEditingController();
  List<String> _solarPanelBrands = [];
  bool _showInventory = false; // ✅ toggles visibility

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
        await uploadImageWithData(selectedOption!, productData);

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
        _solarPanelBrands.add(text); // ✅ local update
        _controller.clear();
      });

      try {
        // Save the whole list to Firestore (you could also push only the new item)
        await FirebaseFirestore.instance
            .collection("torchLightBrands")
            .doc("brandsList") // using a fixed doc ID
            .set({"brands": _solarPanelBrands});

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
              .collection("torchLightBrands")
              .doc("brandsList")
              .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data["brands"] is List) {
          setState(() {
            _solarPanelBrands = List<String>.from(data["brands"]);
            selectedOption = _solarPanelBrands[0];
          });
        }
      }
    } catch (e) {
      print("❌ Failed to load brands: $e");
    }
  }

  String? selectedOption;
  @override
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Placeholder();
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
            crossAxisCount: screenSize.width > 600 ? 3 : 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child:
                        imageBytes != null
                            ? Image.memory(
                              imageBytes,
                              fit: BoxFit.contain,
                              height: 200,
                              width: 200,
                            )
                            : const Icon(Icons.image_not_supported, size: 80),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 6.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product['productName'] ?? 'Unnamed',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "₦${product['price'] ?? '0'}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // TODO: Add to cart logic
                            },
                            child: Text(
                              product['availability'],
                              style: TextStyle(color: Colors.white),
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
        );
      },
    );
  }
}
