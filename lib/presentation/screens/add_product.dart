import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/appCubit/appCubit.dart';
import 'package:task/appCubit/appState.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../utiles/colors.dart';
import '../../utiles/constants.dart';
import '../../utiles/utils.dart';

class AddProductScreen extends StatelessWidget {
   AddProductScreen({Key? key}) : super(key: key);

   List<String> categoriesTitle = [
    Constants.category_1_Title,
    Constants.category_2_Title,
    Constants.category_3_Title,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                MyAppBar(context),
                AddProductSection(context),
                SizedBox(height: 5.h,),
                BuildTextFieldSection(Constants.productNameTxt,TextEditingController()),
                SizedBox(height: 5.h,),
                BuildTextFieldSection(Constants.sellerNameTxt,TextEditingController()),
                SizedBox(height: 5.h,),
                BuildTextFieldSection(Constants.productPriceTxt,TextEditingController()),
                SizedBox(height: 5.h,),
                BuildDropDownSection(Constants.categoryNameTxt,context),
                SizedBox(height: 20.h,),
                AddProductButton(),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyAppBar(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric( horizontal: 10.w),
      width: double.infinity,
      // height: 150,
      child: Stack(
        children: [
          Center(
            child: Text(
              Constants.addProductsTxt,
              style: SafeGoogleFont(
                Constants.montserrat,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 14.w,
            child: GestureDetector(
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget AddProductSection(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) => SizedBox(
        height: 182.h,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Text(
                  Constants.categoriesImagesTxt,
                  style: SafeGoogleFont(
                    Constants.montserrat,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Stack(
              children: [
                Container(
                  //width: 90.w,
                  height: 80.w,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.separated(
                      //shrinkWrap: true,
                      itemBuilder: (context, index) =>
                         Container(
                           height: 80.w, width: 80.w,
                           color: AppColors.white,
                         ),
                      separatorBuilder: (context, index) => const SizedBox(width: 5,),
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ),
                Container(
                  //width: 90.w,
                  height: 80.h,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.separated(
                      //shrinkWrap: true,
                      itemBuilder: (context, index) =>
                      ProductImageItem(BlocProvider.of<AppCubit>(context).newProductImages[index].path,index,context),
                      separatorBuilder: (context, index) => const SizedBox(width: 5,),
                      itemCount: BlocProvider.of<AppCubit>(context).newProductImages.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.w)),
                minimumSize: Size(double.infinity, 50.h),
              ),
              onPressed: () {
                BlocProvider.of<AppCubit>(context).selectedImages();
              },
              child: Directionality(

                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_box,size: 18.sp,color: AppColors.white),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      Constants.tapToAddImageTxt,
                      style: SafeGoogleFont(
                          Constants.montserrat,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget ProductImageItem(String imagePath,int index,BuildContext context) {
      return
        Stack(
        children: [
          // Image.file(File(imagePath),height: 100.h,),
          Image.file(File(imagePath),height: 80.w, width: 80.w,fit: BoxFit.fill,),
          Positioned(
            top: 5.w,
            left: 5.w,
            child: GestureDetector(
              child: Image.asset(Constants.xImage,height: 20.w, width: 20.w,fit: BoxFit.fill,),
              onTap: (){
                BlocProvider.of<AppCubit>(context).removeSelectedImage(index);
              },
            ),)
        ],
      );
  }

  Widget TextFormBuilder({required Controller, hint,validator,key,}){
    return   Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        key: key,
        controller:Controller ,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.borderColor,),
              borderRadius: BorderRadius.circular(15.r)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.borderColor,),
              borderRadius: BorderRadius.circular(15.r)
          ),
          contentPadding:  EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
          hintText: hint,
        ),
      ),
    );

  }

  Widget BuildTextFieldSection(String txt,TextEditingController controller){
    return Column(children: [
      Row(
        children: [
          Spacer(),
          Text(
            txt,
            style: SafeGoogleFont(
              Constants.montserrat,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      TextFormBuilder(Controller: controller,hint: txt),
    ],);
  }

  Widget BuildDropDownSection(String txt,BuildContext context){
    return Column(children: [
      Row(
        children: [
          Spacer(),
          Text(
            txt,
            style: SafeGoogleFont(
              Constants.montserrat,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      dropDownButton(context),
    ],);
  }

  Widget dropDownButton(BuildContext context){
    return
      BlocBuilder<AppCubit,AppState>(builder: (context,state)=>
          Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                alignment: Alignment.centerRight,
                isExpanded: true,
                enableFeedback:true,
                hint: Text(
                  // 'Quality:  '+ (cubit.dropDownFlag?cubit.chosenQuality!:"   ...."onChangeCategoryNameDropDown
                 BlocProvider.of<AppCubit>(context).categoryNameDropDown==null?"اسم الصنف":BlocProvider.of<AppCubit>(context).categoryNameDropDown!,
                  style:
                  SafeGoogleFont(
                    Constants.montserrat,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.myBlue,
                  ),
                ),
                items:
                categoriesTitle.map(( item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    // style:  TextStyle(
                    //   fontSize: Dimensions.p14,
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.white,
                    // ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                )).toList(),
                 value: BlocProvider.of<AppCubit>(context).categoryNameDropDown,
                onChanged: (value) {
                  BlocProvider.of<AppCubit>(context).onChangeCategoryNameDropDown(value);
                },
                buttonStyleData: ButtonStyleData(
                  height: 50.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal:10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.white,
                  ),
                  // elevation: 1,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.expand_circle_down_outlined,
                  ),
                  iconSize: 15.sp,
                  iconEnabledColor: AppColors.myBlue,
                  // iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  // padding: EdgeInsets.all( 50.w),
                  maxHeight: 80.h,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.white,
                  ),
                  offset: const Offset(0, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius:  Radius.circular(10.r),
                    thickness: MaterialStateProperty.all(3.sp),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                menuItemStyleData:  MenuItemStyleData(
                  height: 30.h,
                  padding: EdgeInsets.symmetric(horizontal:10.w),
                ),
              ),
            ),
          ),);

  }

  Widget AddProductButton(){
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.secondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w)),
        minimumSize: Size(double.infinity, 50.h),
      ),
      onPressed: () {},
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Text(
            Constants.addProductTxt,
            style: SafeGoogleFont(
                Constants.montserrat,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white
            ),
          ),
        ),

      ),
    );
  }
}
