import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:justicecorporate/functions/upload_function.dart';
import 'package:justicecorporate/ui/reused_widgets.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RechargeableFans extends StatefulWidget {
  const RechargeableFans({super.key});

  @override
  State<RechargeableFans> createState() => _RechargeableFansState();
}

class _RechargeableFansState extends State<RechargeableFans> {
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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
