import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot item;

  ProductDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['productName']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: item['image1'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text('Category: ${item['category']}'),
            Text('Company: ${item['companyName']}'),
            Text('Calories: ${item['calories']}'),
            Text('Healthy Score: ${item['healthyScore']}'),
            Text('Expiry Date: ${item['expiryDate']}'),
            Text('Description: ${item['description']}'),
            SizedBox(height: 10),
            Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...item['ingredients'].map<Widget>((ingredient) {
              return Text('- ${ingredient['title']}: ${ingredient['description']}');
            }).toList(),
          ],
        ),
      ),
    );
  }
}
