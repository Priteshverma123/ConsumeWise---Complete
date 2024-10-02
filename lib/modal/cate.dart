class Category {
  final String image, name;
  Category({required this.image, required this.name});
}

List<Category> categories = [
  Category(
    image: 'assets/images/Idea.png',
    name: 'Hot Coffee',
  ),
  Category(
    image: 'assets/images/police1.png',
    name: 'Drinks',
  ),
  Category(
    image: 'assets/images/R-eye.png',
    name: 'Hot Teas',
  ),
  Category(
    image: 'assets/images/smallArrow.png',
    name: 'Bakery',
  ),
];

class Product {
  final String image, name;
  final double price;
  final Category category;

  Product(
      {required this.category,
        required this.image,
        required this.name,
        required this.price});
}

List<Product> products = [
  Product(
      image: 'assets/images/dpc.jpg',
      name: 'Blueberry Muffin',
      category: categories[3],
      price: 13),
  Product(
      image: 'assets/images/dpc.jpg',
      name: 'Blueberry Scone',
      category: categories[3],
      price: 12),
  Product(
      image: 'assets/images/dpc.jpg',
      name: 'Butter Croissant',
      category: categories[3],
      price: 10),
  Product(
      image: 'assets/images/dpc.jpg',
      name: 'Petite Vanilla Bean Scone',
      category: categories[3],
      price: 13),
  Product(
      image: 'assets/images/dpc.jpg',
      category: categories[3],
      name: 'Pumpkin Cream Cheese Muffin',
      price: 15),
  Product(
      image: 'assets/images/Phone1.jpg',
      name: 'Evolution Fresh Mighty Watermelon',
      category: categories[1],
      price: 18),
  Product(
      image: 'assets/images/Phone1.jpg',
      name: 'Caramel Brulee Frappuccino Blended Beverage',
      category: categories[1],
      price: 18),
  Product(
      image: 'assets/images/Phone1.jpg',
      category: categories[1],
      name: 'Pink Drink Starbucks Refreshers Beverage',
      price: 18),
  Product(
      image: 'assets/images/Phone1.jpg',
      category: categories[1],
      name: 'Pistachio Frappuccino Blended Beverage',
      price: 18),
  Product(
      image: 'assets/images/Phone1.jpg',
      category: categories[1],
      name: 'Strawberry Creme Frappuccino Blended Beverage',
      price: 18),
  Product(
      image: 'assets/images/Mdoc3.png',
      category: categories[0],
      name: 'Caffe Americano',
      price: 18),
  Product(
      image: 'assets/images/Mdoc3.png',
      name: 'Mistletoe Coffee',
      category: categories[0],
      price: 18),
  Product(
      image: 'assets/images/Mdoc3.png',
      name: 'Cappuccino',
      category: categories[0],
      price: 18),
  Product(
      image: 'assets/images/Mdoc3.png',
      category: categories[0],
      name: 'Featured Medium Roast - Pike Place Roast',
      price: 18),
  Product(
      image: 'assets/images/Mdoc3.png',
      category: categories[0],
      name: 'Honey Almondmilk Flat White',
      price: 18),
  Product(
      category: categories[2],
      image: 'assets/images/MDoc.png',
      name: 'Chai Tea Latte',
      price: 18),
  Product(
      image: 'assets/images/MDoc.png',
      category: categories[2],
      name: 'Chai Tea',
      price: 18),
  Product(
      image: 'assets/images/MDoc.png',
      category: categories[2],
      name: "Emperor's Clouds & Mist",
      price: 18),
  Product(
      image: 'assets/images/MDoc.png',
      category: categories[2],
      name: 'Honey Citrus Mint Tea',
      price: 18),
  Product(
      image: 'assets/images/MDoc.png',
      category: categories[2],
      name: 'Matcha Tea Latte',
      price: 18),
];