import 'package:flutter/material.dart';
import 'package:justicecorporate/functions/upload_function.dart';
import 'package:justicecorporate/ui/reused_widgets.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Torchlight extends StatefulWidget {
  const Torchlight({super.key});

  @override
  State<Torchlight> createState() => _TorchlightState();
}

class _TorchlightState extends State<Torchlight> {
  final TextEditingController _controller = TextEditingController();
  List<String> _torchLightBrands = [];
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
        _torchLightBrands.add(text); // ✅ local update
        _controller.clear();
      });

      try {
        // Save the whole list to Firestore (you could also push only the new item)
        await FirebaseFirestore.instance
            .collection("torchLightBrands")
            .doc("brandsList") // using a fixed doc ID
            .set({"brands": _torchLightBrands});

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
            _torchLightBrands = List<String>.from(data["brands"]);
            selectedOption = _torchLightBrands[0];
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
        body: Column(
          children: [
            // Header Widget
            HeaderWidget(screenSize: screenSize),
            //Page Title
            Text('TORCH LIGHT'),

            // Body with inventory + divider + grid
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (screenSize.width > 600)
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1000,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('INVENTORY'),
                              SizedBox(height: 3),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _torchLightBrands.length,
                                  itemBuilder: (context, index) {
                                    final torchBrand = _torchLightBrands[index];
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
                              ),
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
                                    child: Text("Add TorchLight Brand"),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _productNameController,
                                        decoration: InputDecoration(
                                          labelText: "Product Name",
                                        ),
                                        validator:
                                            (value) =>
                                                value == null || value.isEmpty
                                                    ? "Enter product name"
                                                    : null,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: _unitsController,
                                        decoration: InputDecoration(
                                          labelText: "No. of Units in Carton",
                                        ),
                                        validator:
                                            (value) =>
                                                value == null || value.isEmpty
                                                    ? "Enter units"
                                                    : null,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: _availabilityController,
                                        decoration: InputDecoration(
                                          labelText: "Availability",
                                        ),
                                        validator:
                                            (value) =>
                                                value == null || value.isEmpty
                                                    ? "Enter availability"
                                                    : null,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          _addProduct();
                                        },
                                        child: Text("Add Product"),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (screenSize.width > 600)
                    Container(
                      height: double.infinity,
                      color: Colors.black,
                      width: 2,
                    ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        if (screenSize.width < 600)
                          ElevatedButton.icon(
                            icon: Icon(
                              _showInventory
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                            label: Text(
                              _showInventory
                                  ? "Hide Inventory"
                                  : "Show Inventory",
                            ),
                            onPressed: () {
                              setState(() {
                                _showInventory = !_showInventory;
                              });
                            },
                          ),

                        if (screenSize.width < 600 && _showInventory)
                          Expanded(
                            // 👈 give inventory scrollable space
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('INVENTORY'),
                                  const SizedBox(height: 3),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        NeverScrollableScrollPhysics(), // 👈 avoid nested scrolls
                                    itemCount: _torchLightBrands.length,
                                    itemBuilder: (context, index) {
                                      final torchBrand =
                                          _torchLightBrands[index];
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
                                    child: const Text("Add TorchLight Brand"),
                                  ),
                                  const SizedBox(height: 20),
                                  // form
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _productNameController,
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
                                            controller: _availabilityController,
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
                                            child: const Text("Add Product"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
