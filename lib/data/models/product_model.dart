class Products {
  int? status;
  String? message;
  List<Product>? products;

  Products({this.status, this.message, this.products});

  Products.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? name;
  String? sellerName;
  int? price;
  String? category;
  List<String>? images;

  Product(
      {this.name, this.sellerName, this.price, this.category, this.images});

  Product.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    sellerName = json['sellerName'];
    price = json['price'];
    category = json['category'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sellerName'] = this.sellerName;
    data['price'] = this.price;
    data['category'] = this.category;
    data['images'] = this.images;
    return data;
  }
}