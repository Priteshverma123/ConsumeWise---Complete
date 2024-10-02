import 'package:flutter/material.dart';

class ItemDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;

  ItemDetailPage({required this.item});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF76B2E4),
        title: Text(
          widget.item['productName'] ?? 'Unknown Product',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index; // Update the current index
                      });
                    },
                    children: [
                      Image.network(
                        widget.item['image1'] ?? '',
                        fit: BoxFit.contain,
                      ),
                      if (widget.item['image2'] != null)
                        Image.network(
                          widget.item['image2'] ?? '',
                          fit: BoxFit.contain,
                        ),
                      if (widget.item['image3'] != null)
                        Image.network(
                          widget.item['image3'] ?? '',
                          fit: BoxFit.contain,
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 100,
                  child: Column(
                    children: List.generate(
                      3,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 5),
                        width: 10,
                        height: index == _currentIndex ? 20 : 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _currentIndex == index
                              ? const Color(0xFFFFC83A)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.item['productName'] ?? 'Unknown Product',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF76B2E4),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bordered Container for Details
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF76B2E4), width: 2),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white, // Optional: Set a background color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Details with Icons
                  _buildDetailRow(Icons.description, 'Description',
                      widget.item['description'] ?? 'No Description Available'),
                  _buildDetailRow(Icons.fastfood, 'Calories',
                      widget.item['calories']?.toString() ?? 'N/A'),
                  _buildDetailRow(Icons.category, 'Category',
                      widget.item['category'] ?? 'N/A'),
                  _buildDetailRow(Icons.business, 'Company Name',
                      widget.item['companyName'] ?? 'Unknown'),
                  _buildDetailRow(Icons.star, 'Healthy Score',
                      widget.item['healthyScore']?.toString() ?? 'N/A'),
                  _buildDetailRow(Icons.add_shopping_cart, 'Quantity',
                      widget.item['quantity']?.toString() ?? 'N/A'),
                  _buildDetailRow(Icons.score, 'Nutrient Score',
                      widget.item['nutrientScore']?.toString() ?? 'N/A'),
                  _buildDetailRow(Icons.cake, 'Packaging',
                      widget.item['packaging'] ?? 'N/A'),
                  const SizedBox(height: 16),

                  // Ingredients
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF76B2E4),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ...List.generate(
                    widget.item['ingredients']?.length ?? 0,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          '- ${widget.item['ingredients'][index]['title'] ?? 'Unknown'}: ${widget.item['ingredients'][index]['description'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  // Helper method to build detail rows with icons
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: const Color(0xFFFFC83A)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontSize: 18, // Increased font size
                      fontWeight: FontWeight.bold, // Bold text
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 16, // Regular font size for value
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
