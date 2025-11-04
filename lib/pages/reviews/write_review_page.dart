// File baru: lib/pages/reviews/write_review_page.dart

import 'package:flutter/material.dart';
import '../../data/products_data.dart'; // Untuk mengambil daftar produk

class WriteReviewPage extends StatefulWidget {
  // Terima produk yang mau direview dari halaman sebelumnya
  final Map<String, dynamic> initialProduct;

  const WriteReviewPage({super.key, required this.initialProduct});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  late Map<String, dynamic> _selectedProduct;
  double _rating = 3.0; // Rating awal
  final TextEditingController _reviewController = TextEditingController();

  // Warna utama dari screenshot
  final Color primaryColor = const Color(0xFF4B3B47);

  @override
  void initState() {
    super.initState();
    _selectedProduct = widget.initialProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Info Produk ---
            _buildProductInfo(),
            const SizedBox(height: 16),
            const Divider(height: 24),

            // --- 2. Rating ---
            const Text(
              "What do you think?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              style: TextStyle(color: Colors.grey, height: 1.4),
            ),
            const SizedBox(height: 20),
            _buildInteractiveRating(),
            const SizedBox(height: 24),

            // --- 3. Text Field Review ---
            TextField(
              controller: _reviewController,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "Write your review here",
                fillColor: Colors.grey.shade50,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 100), // Spasi untuk tombol
          ],
        ),
      ),
      // --- 4. Tombol Submit (mengambang di bawah) ---
      bottomNavigationBar: _buildSubmitButton(context),
    );
  }

  // == WIDGET BUILDERS ==

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Write Reviews",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Row(
      children: [
        // Gambar
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            _selectedProduct['image'] ?? 'assets/images/product1.jpg',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        // Info Teks
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedProduct['title'] ?? 'Nama Produk',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _selectedProduct['category'] ?? 'Kategori',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        // Tombol Change
        TextButton(
          onPressed: _showProductPicker,
          child: Text(
            "Change",
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Bintang
        Row(
          children: List.generate(5, (index) {
            final starNumber = index + 1;
            return IconButton(
              onPressed: () {
                setState(() {
                  _rating = starNumber.toDouble();
                });
              },
              icon: Icon(
                starNumber <= _rating ? Icons.star : Icons.star_border,
                color: Colors.orange,
                size: 32,
              ),
            );
          }),
        ),
        // Teks Rating
        Text(
          _rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      // SafeArea untuk tombol
      padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).padding.bottom + 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _showThankYouDialog,
        child: const Text(
          "SUBMIT REVIEW",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // == FUNGSI INTERAKSI ==

  void _showProductPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar bisa setengah layar
      shape: const RoundedRectangleBorder(
         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Ambil daftar produk dari data mock
        final allProducts = products;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5, // Muncul setengah layar
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Column(
            children: [
              // Grabber
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Text(
                "Pilih Menu yang Akan Direview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController, // Hubungkan controller
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    final product = allProducts[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(product['title']),
                      subtitle: Text(product['category']),
                      onTap: () {
                        setState(() {
                          _selectedProduct = product;
                        });
                        Navigator.pop(context); // Tutup bottom sheet
                      },
                    );
                  },
                ),
              ),
            ],
          );
          },
        );
      },
    );
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Terima Kasih!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Review Anda telah berhasil dikirimkan.",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali dari halaman review
              },
              child: const Text(
                "Kembali",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}