
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../models/product_model.dart';
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
class LocaleStorage {
   static late Box productsBox;

  Future<void> openBoxes()async{
    productsBox= await Hive.openBox(CACHE_HOME_KEY);
  }
  Future<bool> isProductBoxEmpty()async{
    if(!productsBox.isOpen) {
      await openBoxes();
    }
    if(!productsBox.isNotEmpty || productsBox == null) {
    return true;
    }else {
      return false;
    }
  }
  Future<void> saveProductsToCache(Products products)async{
    if(!productsBox.isOpen) {
      await openBoxes();
    }
    productsBox.put(CACHE_HOME_KEY, products.toJson());
  }
  Future<Products> getProducts()async{
    Products? product;
    if(!productsBox.isOpen) {
      await openBoxes();
    }
    if(productsBox.isNotEmpty) {
       product = Products.fromJson(productsBox.toMap()[CACHE_HOME_KEY]);
    }
    return product??Products();
  }
}
