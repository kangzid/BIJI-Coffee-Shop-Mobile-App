import 'package:flutter/material.dart';
import 'package:biji_coffee/pages/cart/cart_page.dart';
import 'package:biji_coffee/data/services/product_service.dart';
import 'detail_product_page.dart'; // Adjusted relative import if needed or keep absolute if it works

class ProductsPage extends StatefulWidget {
  final String? selectedCategory;

  const ProductsPage({super.key, this.selectedCategory});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  final ProductService _productService = ProductService();

  late String selectedCategory;
  String searchQuery = '';
  List<Map<String, dynamic>> _allProducts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  // Hardcoded categories for tabs - could also be fetched from API
  final List<String> categories = ['Beverages', 'Snacks', 'Food', 'Dessert'];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory ?? 'Beverages';
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      // Fetch all products to allow client-side filtering and search
      // passing 'All' or null to fetch everything if API supports it,
      // otherwise fetch by category if API requires it.
      // Based on service, passing null fetches all (if API endpoint ./products returns all).
      // If API requires category, we might need to fetch multiple times or just current category.
      // Let's assume fetching all is better for search.
      final products = await _productService.fetchProducts();

      if (mounted) {
        setState(() {
          _allProducts = products;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Colors.orange)),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading products:\n$_errorMessage',
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = '';
                  });
                  _fetchProducts();
                },
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      );
    }

    final filteredProducts = _allProducts.where((product) {
      final title =
          (product['title'] ?? product['name'] ?? '').toString().toLowerCase();
      final matchesSearch = title.contains(searchQuery.toLowerCase());

      // Category check
      // API might return category name. Ensure it matches tab names.
      // If API category is different, this filter might hide everything.
      // Let's check logic: selectedCategory default is 'Beverages'.
      // If selectedCategory == 'All', show all.
      final productCategory = product['category'] ?? '';
      final matchesCategory =
          selectedCategory == 'All' || productCategory == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // 🔍 Search & Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() => searchQuery = val);
                        },
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Search here...',
                          hintStyle: const TextStyle(
                            color: Color(0xFFBDBDBD),
                            fontSize: 15,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFF424242),
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🧭 Category Tabs
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => selectedCategory = category),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 20,
                                color: isSelected
                                    ? Colors.black
                                    : const Color(0xFFBDBDBD),
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (isSelected)
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF9800),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🛍️ Product Grid
              filteredProducts.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("No products found"),
                      ),
                    )
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: GridView.builder(
                        key: ValueKey(selectedCategory + searchQuery),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.55,
                        ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return _buildProductCard(product);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    // Determine image provider (Network or Asset)
    final imagePath = product['image'] ?? '';
    final isNetworkImage = imagePath.toString().startsWith('http');
    final title = product['title'] ?? product['name'] ?? 'No Name';
    final price = product['price'] ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return FadeTransition(
                opacity: curvedAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.05),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                ),
              );
            },
            pageBuilder: (_, __, ___) => ProductDetailPage(product: product),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Hero(
                      tag: 'product-$title-$price',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: isNetworkImage
                              ? Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(Icons.broken_image,
                                          size: 40, color: Colors.grey),
                                    );
                                  },
                                )
                              : Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(Icons.image,
                                          size: 40, color: Colors.grey),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 300),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                final curvedAnimation = CurvedAnimation(
                                    parent: animation, curve: Curves.easeInOut);
                                return FadeTransition(
                                  opacity: curvedAnimation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.05),
                                      end: Offset.zero,
                                    ).animate(curvedAnimation),
                                    child: child,
                                  ),
                                );
                              },
                              pageBuilder: (_, __, ___) => const CartPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              const SizedBox(height: 3),
              Text(
                product['subtitle'] ?? '',
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.local_offer_outlined,
                    size: 14,
                    color: Color(0xFF757575),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '\$${price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
