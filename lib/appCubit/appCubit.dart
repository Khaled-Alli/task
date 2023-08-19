import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/models/product_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data/local_storage/local_storage.dart';
import '../data/web_services/app_web_service.dart';
import 'appState.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit():super(InitialState());
   LocaleStorage localStorage =LocaleStorage();
   Products? products;
   bool isViewHorizontal = false;
   List<XFile> newProductImages=[];
   String? categoryNameDropDown;
   final InternetConnectionChecker internetConnectionChecker=InternetConnectionChecker();


  Future<Products> getProducts()async{

      if(await localStorage.isProductBoxEmpty() || await internetConnectionChecker.hasConnection){
        AppWebServices.getProducts().then((value) async {
            products = Products.fromJson(value);
            await localStorage.saveProductsToCache(products!);
        }).then((value) => emit(GetProduct()));
      }else{
        products = await localStorage.getProducts();
        emit(GetProduct());
      }
   //   emit(GetProduct());
    return products??Products();
  }

  void changeHomeView(){
    isViewHorizontal = !isViewHorizontal;
    emit(ChangeHomeView());
  }

  Future<void> selectedImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      newProductImages.addAll(selectedImages);
    }
    emit(SelectedImages());
  }

  void removeSelectedImage(int index){
    newProductImages.removeAt(index);
    emit(RemoveSelectedImage());
  }

  void onChangeCategoryNameDropDown(String? val){
    categoryNameDropDown =val;
    emit(OnChangeCategoryNameDropDown());
  }

  void reset(){
    newProductImages=[];
    categoryNameDropDown=null;
    emit(Reset());
  }
}