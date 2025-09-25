import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justicecorporate/functions/loadBrandsFromFirestore.dart';
import 'package:justicecorporate/functions/upload_function.dart';
import 'package:justicecorporate/ui/reused_widgets.dart';

class Torchlight extends StatefulWidget {
  const Torchlight({super.key});

  @override
  State<Torchlight> createState() => _TorchlightState();
}

class _TorchlightState extends State<Torchlight> {
  final TextEditingController _controller = TextEditingController();
  List<String> _torchLightBrands = [];
  bool isClicked = false;
  bool isHovered = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _loadBrandsFromFirestore();
  }

  //This function loads the torchlight brands from database.
  Future<void> _loadBrandsFromFirestore() async {
    final brands = await FirestoreService.getListFromFirestore(
      collection: "torchLightBrands",
      doc: "brandsList",
      field: "brands",
    );

    if (!mounted) return; // avoid calling setState after widget disposal

    setState(() {
      _torchLightBrands = brands;
      selectedOption = brands.isNotEmpty ? brands[0] : null;
    });
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate() && selectedOption != null) {
      Map<String, dynamic> productData = {
        "productName": _productNameController.text.trim(),
        "unitsInCarton": _unitsController.text.trim(),
        "availability": _availabilityController.text.trim(),
      };

      try {
        await uploadImageWithData('TorchLight', selectedOption!, productData);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Product uploaded with image")),
        );

        _productNameController.clear();
        _unitsController.clear();
        _availabilityController.clear();
      } catch (e) {
        if (!mounted) return;
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
        _torchLightBrands.add(text);
        _controller.clear();
      });

      try {
        await FirebaseFirestore.instance
            .collection("torchLightBrands")
            .doc("brandsList")
            .set({"brands": _torchLightBrands});

        print("✅ List updated in Firestore");
      } catch (e) {
        print("❌ Failed to upload list: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //Header Row
            Header(screenSize: screenSize),

            //Title of Page
            Text(
              'Torch Light',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
            ),

            //Body of Page
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (screenSize.width >
                      800) //this only shows when screen is desktop size
                    Expanded(flex: 1, child: _brandsListToggle()),

                  if (screenSize.width >
                      800) //this only shows when screen is desktop size
                    const VerticalDivider(thickness: 1),

                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (screenSize.width < 800) _brandsListToggle(),

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
                                      formKey: _formKey,
                                      productNameController:
                                          _productNameController,
                                      unitsController: _unitsController,
                                      availabilityController:
                                          _availabilityController,
                                      onAddProduct: _addProduct,
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

  Widget _brandsListToggle() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: GestureDetector(
                onTap: () => setState(() => isClicked = !isClicked),
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(
                    vertical: !kIsWeb ? 0 : 5,
                    horizontal: 5,
                  ),
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    color:
                        isHovered ? Colors.grey.shade400 : Colors.transparent,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedOption ?? 'TorchLight Brands',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 100),
                      Transform.rotate(
                        angle: isClicked ? math.pi / 2 : math.pi * 1.5,
                        child: const Icon(Icons.arrow_back_ios, size: 15),
                      ),
                      if (!kIsWeb)
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text("Add Brand"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _controller,
                                          decoration: const InputDecoration(
                                            labelText: "Enter brand",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            _addItem();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "Add TorchLight Brand",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                          icon: const Icon(Icons.add, size: 20),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            if (isClicked)
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
                        value: torchBrand,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                      ),
                      onTap: () => setState(() => selectedOption = torchBrand),
                    );
                  },
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
  final GlobalKey<FormState> formKey;
  final TextEditingController productNameController;
  final TextEditingController unitsController;
  final TextEditingController availabilityController;
  final Future<void> Function() onAddProduct;

  const ProductsGrid({
    super.key,
    required this.selectedOption,
    required this.formKey,
    required this.productNameController,
    required this.unitsController,
    required this.availabilityController,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('TorchLight')
              .doc(selectedOption)
              .collection('products')
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyState(context);
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenSize.width > 800 ? 3 : 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length + 1,
          itemBuilder: (context, index) {
            final product =
                index != products.length
                    ? products[index].data() as Map<String, dynamic>
                    : null;

            Uint8List? imageBytes;
            if (product?['imageBase64'] != null) {
              imageBytes = base64Decode(product?['imageBase64']);
            }

            //return (index == products.length && !kIsWeb)
            return (index == products.length)
                ? (!kIsWeb ? _buildEmptyState(context) : null)
                : Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    width: double.infinity,
                                  )
                                  : const Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product?['productName'] ?? 'Unnamed',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("${product?['unitsInCarton'] ?? '0'} units"),
                            Text(
                              product?['availability'] ?? '',
                              style: const TextStyle(color: Colors.green),
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text("Add Product"),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: productNameController,
                                decoration: const InputDecoration(
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
                                controller: unitsController,
                                decoration: const InputDecoration(
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
                                controller: availabilityController,
                                decoration: const InputDecoration(
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
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await onAddProduct();
                                    Navigator.of(
                                      context,
                                    ).pop(); // only closes if valid
                                  }
                                },
                                child: const Text("Add Product"),
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Upload Products'),
        ],
      ),
    );
  }
}
