import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String selectedCategoryLeft = "All";
  String selectedCategoryRight = "All";
  String searchQueryLeft = "";
  String searchQueryRight = "";
  TextEditingController searchControllerLeft = TextEditingController();
  TextEditingController searchControllerRight = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchControllerLeft.dispose();
    searchControllerRight.dispose();
  }

  Color getScoreColor(int score) {
    if (score > 70) {
      return Colors.green;
    } else if (score > 30) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page with Items'),
      ),
      body: Column(
        children: [
          // Left Side - List of items
          Expanded(
            child: Column(
              children: [
                _buildSearchAndFilterSection(
                  context,
                  searchControllerLeft,
                  selectedCategoryLeft,
                      (newCategory) {
                    setState(() {
                      selectedCategoryLeft = newCategory;
                    });
                  },
                      (searchQuery) {
                    setState(() {
                      searchQueryLeft = searchQuery;
                    });
                  },
                ),
                Expanded(
                  child: _buildItemList(
                    selectedCategory: selectedCategoryLeft,
                    searchQuery: searchQueryLeft,
                    size: size,
                  ),
                ),
              ],
            ),
          ),
          // Right Side - List of items
          Expanded(
            child: Column(
              children: [
                _buildSearchAndFilterSection(
                  context,
                  searchControllerRight,
                  selectedCategoryRight,
                      (newCategory) {
                    setState(() {
                      selectedCategoryRight = newCategory;
                    });
                  },
                      (searchQuery) {
                    setState(() {
                      searchQueryRight = searchQuery;
                    });
                  },
                ),
                Expanded(
                  child: _buildItemList(
                    selectedCategory: selectedCategoryRight,
                    searchQuery: searchQueryRight,
                    size: size,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterSection(
      BuildContext context,
      TextEditingController searchController,
      String selectedCategory,
      Function(String) onCategorySelected,
      Function(String) onSearchQueryChanged,
      ) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) => onSearchQueryChanged(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search items',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  onSearchQueryChanged('');
                },
              ),
            ],
          ),
        ),
        // Category filter
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            List<String> categories = ["All"];
            for (var doc in snapshot.data!.docs) {
              String category = doc['category'];
              if (!categories.contains(category)) {
                categories.add(category);
              }
            }

            return SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ChoiceChip(
                    label: Text(categories[index]),
                    selected: selectedCategory == categories[index],
                    onSelected: (selected) {
                      onCategorySelected(categories[index]);
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildItemList({
    required String selectedCategory,
    required String searchQuery,
    required Size size,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('items').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        var items = snapshot.data!.docs;

        if (selectedCategory != "All") {
          items = items.where((item) => item['category'] == selectedCategory).toList();
        }
        if (searchQuery.isNotEmpty) {
          items = items.where((item) => item['productName'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Single column in the divided sections
            childAspectRatio: 2, // Adjust as needed for better spacing
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];

            return Card(
              child: Stack(
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: item['image1'],
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(item['productName']),
                    ],
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: getScoreColor(int.parse(item['nutrientScore'])),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Score: ${item['nutrientScore']}',
                        style: const TextStyle(color: Colors.white),
                      ),
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
