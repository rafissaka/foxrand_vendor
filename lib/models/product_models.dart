class Product {
  final String docId;
  final bool fragile;
  final bool hazardous;
  final List<String> colorAvailable;
  final double currentHazardValue;
  final double currentSliderValue;
  final String productDesc;
  final String productName;
  final double productPrice;
  final List<String> productUrls;
  final String selectedCategory;
  final String seller;

  Product({
    required this.docId,
    required this.fragile,
    required this.hazardous,
    required this.colorAvailable,
    required this.currentHazardValue,
    required this.currentSliderValue,
    required this.productDesc,
    required this.productName,
    required this.productPrice,
    required this.productUrls,
    required this.selectedCategory,
    required this.seller,
  });
}
