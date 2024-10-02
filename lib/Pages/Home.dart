import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Compo/user_controller.dart';
import 'package:fluttercuredoc/Pages/HOmePage/category-item.dart';
import 'package:fluttercuredoc/Pages/HOmePage/selfbackgorund.dart';
import 'package:fluttercuredoc/Profile/EditProfile.dart';
import 'package:get/get.dart';

import '../modal/cate.dart';
import 'HOmePage/Item-detail.dart';
import 'HOmePage/colors.dart';
import 'HOmePage/detail.dart';
import 'HOmePage/itempage.dart';
import 'HOmePage/product_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.isNetworkImage = false}) : super(key: key);
  final bool isNetworkImage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? controller;
  String selectedCategory = "All"; // State to keep track of selected category
  String searchQuery = ""; // State to keep track of search query
  TextEditingController searchController = TextEditingController(); // Controller for search input

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
    searchController.dispose(); // Dispose of the search controller

  }
  Color getScoreColor(int score) {
    if (score > 70) {
      return Colors.green; // Green for score > 70
    } else if (score > 30) {
      return Colors.yellow; // Yellow for score between 31 and 70
    } else {
      return Colors.red; // Red for score <= 30
    }
  }
  @override
  Widget build(BuildContext context) {
    final controllers = Get.put(UserController());
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: builddAppBar(context, controllers),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: size.height * 0.4,
              color: Colors.amberAccent,
            ),
            const Background(),
            buildPositioned(size),
            // Categories
            Positioned(
              top: 400,
              left:10,
              right: 10,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // Extract categories from the items
                  List<String> categories = ["All"]; // Start with "All"
                  for (var doc in snapshot.data!.docs) {
                    String category = doc['category'];
                    if (!categories.contains(category)) {
                      categories.add(category);
                    }
                  }

                  return Container(
                    width: size.width,
                    height: 80, // Adjust height for categories
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(categories[index],style: const TextStyle(fontSize: 16),),
                            ),
                            selected: selectedCategory == categories[index],
                            backgroundColor:const Color(0xFFF1E3CE),
                            selectedColor: Colors.amberAccent, // Set selected background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0), // Set border radius
                              side: BorderSide(
                                color: selectedCategory == categories[index] ? Colors.transparent : Colors.grey, // Border color when not selected
                              ),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = categories[index];
                              });
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            // GridView for Items
            Positioned(
              top: 470, // Adjust based on the height of your category list
              left: 0,
              right: 0,
              bottom: -10,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('items').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    // Extract item data
                    var items = snapshot.data!.docs;

                    // Filter items based on selected category
                    if (selectedCategory != "All") {
                      items = items.where((item) => item['category'] == selectedCategory).toList();
                    }
                    if (searchQuery.isNotEmpty) {
                      items = items.where((item) => item['productName'].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(), // Enable scrolling for the GridView
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        childAspectRatio: 0.75, // Adjust the aspect ratio as needed
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var item = items[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetailPage(item: item.data() as Map<String, dynamic>),
                              ),
                            );
                          },
                          child: Card(
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0), // Adjust the radius as needed
                                        topRight: Radius.circular(16.0), // Adjust the radius as needed
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: item['image1'],
                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        height: 120,
                                        width: size.width, // Adjust as needed
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Title text
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: size.width * 0.4, // Limit width to 80% of the card width
                                        ),
                                        child: Text(
                                          item['productName'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                          overflow: TextOverflow.ellipsis, // Prevent overflow
                                          maxLines: 2, // Limit to 2 lines
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Positioned container for the score at bottom right
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Padding for the score container
                                    decoration: BoxDecoration(
                                      color: getScoreColor(int.parse(item['nutrientScore'])), // Convert score to int
                                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                    ),
                                    child: Text(
                                      'Score: ${item['nutrientScore']}',
                                      style: const TextStyle(color: Colors.white), // Text color
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        );
                      },                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

AppBar builddAppBar(BuildContext context, UserController controller) {
    return AppBar(
      backgroundColor: Colors.amberAccent,
      title: const Text(
        'Consume Wise',
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo2.png',
            fit: BoxFit.cover,
            width: 60,
            height: 60,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfile()),
            );
          },
          child: Obx(() {
            final networkImage = controller.user.value.profilePicture;
            final image = networkImage.isNotEmpty
                ? networkImage
                : 'assets/images/profile.png';
            return Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Center(
                  child: networkImage.isNotEmpty
                      ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: image,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                      : Image(
                    fit: BoxFit.cover,
                    image: widget.isNetworkImage
                        ? NetworkImage(image)
                        : AssetImage(image) as ImageProvider,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
  Positioned buildPositioned(Size size) {
    return Positioned(
          top: 0, // Adjust the position to fit the design
          left: 0,
          right: 0,
          child: SizedBox(
            height: size.height * 0.6, // Adjust the height as necessary
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Find your best\n",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: "food",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "products",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 65,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController, // Use the controller here
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery = value; // Update the search query state
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Search Grocery",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              // IconButton to clear the text
                              IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchController.clear(); // Clear the text in the TextField
                                    searchQuery = ""; // Clear the search query state
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only( top: 40, left:20,right:20),
                    child:appBanners()
                ),
              ],
            ),
          ),
        );
  }
  Container appBanners() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xff76B2E4),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "The Fastest In Delivery ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Food",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),
                  child: const Text(
                    "Check Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
          Image.asset("assets/images/online D_P.jpg")
        ],
      ),
    );
  }

}
class Clips extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100);
    path.quadraticBezierTo(size.width / 2, -40, 0, 100);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}