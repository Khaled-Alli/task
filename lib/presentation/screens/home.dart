
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/appCubit/appCubit.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/utiles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task/utiles/constants.dart';
import '../../appCubit/appState.dart';
import '../../utiles/utils.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<String> imgPath = [
    Constants.categoriesImage,
    Constants.category_1_Image,
    Constants.category_2_Image,
    Constants.category_3_Image,
  ];
  List<String> categoriesTitle = [
    Constants.categoriesTitle,
    Constants.category_1_Title,
    Constants.category_2_Title,
    Constants.category_3_Title,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              MyAppBar(context),
              MyCategory(),
              ChangePresentationSection(context),
              BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                if (BlocProvider.of<AppCubit>(context).products?.status==200 ||
                    BlocProvider.of<AppCubit>(context).products?.status!=null) {
                  return
                    BlocProvider.of<AppCubit>(context).isViewHorizontal?
                     CreateHorizontalProductsView(products: BlocProvider.of<AppCubit>(context).products!,)
                   : CreateVerticalProductsView(products: BlocProvider.of<AppCubit>(context).products!,);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyAppBar(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Text(
              Constants.productsTxt,
              style: SafeGoogleFont(
                Constants.montserrat,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
              left: 0,
              top:16.w ,
              child: GestureDetector(child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: const Icon(Icons.add),
              ), onTap: () {
                BlocProvider.of<AppCubit>(context).reset();
                Navigator.of(context).pushNamed(Constants.addProductRout);
              },
            ),

          ),
        ],
      ),
    );
  }

  Widget MyCategory() {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            Text(
              Constants.categoriesTxt,
              style: SafeGoogleFont(
                Constants.montserrat,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          //width: 90.w,
          height: 100.h,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
              //shrinkWrap: true,
              itemBuilder: (context, index) =>
                  CategoryItem(categoriesTitle[index], imgPath[index]),
              separatorBuilder: (context, index) => SizedBox(
                width: 8,
              ),
              itemCount: categoriesTitle.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
            ),
          ),
        ),
      ],
    );
  }

  Widget CategoryItem(String txt, String img) {
    return Container(
      width: 90.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              img,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            txt,
            style: SafeGoogleFont(
              Constants.montserrat,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget ChangePresentationSection(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Container(
            width: 175.w,
            height: 35.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r)),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
                    child: Image.asset(
                      Constants.changePresentationImage,
                      height: 20.h,
                      width: 20.h,
                    ),
                  ),
                 BlocBuilder<AppCubit,AppState>(builder: (context,state)=>Text(
                   Constants.changePresentationTxt +
                       (BlocProvider.of<AppCubit>(context).isViewHorizontal?"رأسي":"افقي"),
                   style: SafeGoogleFont(
                     Constants.montserrat,
                     fontSize: 12.sp,
                     color: AppColors.myRedColor,
                     fontWeight: FontWeight.w700,
                   ),
                 ),),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
      onTap: ()=>BlocProvider.of<AppCubit>(context).changeHomeView(),
    );
  }
}

class CreateVerticalItem extends StatelessWidget {
  Product? product;

  CreateVerticalItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 110.h,
        width: double.infinity,
        // margin: EdgeInsets.all(5.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                height: 100.h,
                width: 100.h,
                imageUrl: product!.images![0],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Container(
                  width: 100.h,
                  height: 100.h,
                  color: AppColors.grayColor,
                  child: const Icon(Icons.error),
                ),
              ),
              // Image.network(
              //   "https://th.bing.com/th/id/OIG.XtXUYlvx3YPMRDjwXTOI" , //  product!.images[0],//fit: BoxFit.fill,
              // ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 190.w,
                    child: Text(
                      product!.name!,
                      style: SafeGoogleFont(
                        Constants.montserrat,
                        fontSize: 16.sp,
                        //color: AppColors.myRedColor,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Text(
                      product!.price.toString(),
                      style: SafeGoogleFont(
                        Constants.montserrat,
                        fontSize: 24.sp,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(Constants.dollarTxt,
                        style: SafeGoogleFont(
                          Constants.montserrat,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textHeightBehavior: TextHeightBehavior()),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  height: 25.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: AppColors.deepGrayColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      product!.sellerName!,
                      style: SafeGoogleFont(
                        Constants.montserrat,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreateVerticalProductsView extends StatelessWidget {
  Products products;

  CreateVerticalProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5755,
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (context, index) => CreateVerticalItem(
          product: products.products![index]!,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemCount: products.products!.length,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}

class CreateHorizontalProductsView extends StatelessWidget {
  Products products;

  CreateHorizontalProductsView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5755,
      width: double.infinity,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1 / 1.5,
        ),
        itemBuilder: (context, index) {
          return CreateHorizontalItem(
            product: products.products![index],
          );
        },
        itemCount: products.products!.length,
      ),
    );
  }
}

class CreateHorizontalItem extends StatelessWidget {
  Product? product;

  CreateHorizontalItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        // height: 260.h,
        // width: double.infinity,
        // margin: EdgeInsets.all(5.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                height: 130.h,
                width: 140.h,
                imageUrl: product!.images![0],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Container(
                  width: 140.h,
                  height: 130.h,
                  color: AppColors.grayColor,
                  child: const Icon(Icons.error),
                ),
              ),
              // Image.network(
              //   "https://th.bing.com/th/id/OIG.XtXUYlvx3YPMRDjwXTOI" , //  product!.images[0],//fit: BoxFit.fill,
              // ),
            ),
            SizedBox(
              height: 10.w,
            ),
            SizedBox(
                width: 190.w,
                child: Text(
                  product!.name!,
                  style: SafeGoogleFont(
                    Constants.montserrat,
                    fontSize: 16.sp,
                    //color: AppColors.myRedColor,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                )),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      product!.price.toString(),
                      style: SafeGoogleFont(
                        Constants.montserrat,
                        fontSize: 24.sp,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(Constants.dollarTxt,
                        style: SafeGoogleFont(
                          Constants.montserrat,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textHeightBehavior: TextHeightBehavior()),
                  ],
                ),
                Container(
                  height: 25.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: AppColors.deepGrayColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      product!.sellerName!,
                      style: SafeGoogleFont(
                        Constants.montserrat,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

