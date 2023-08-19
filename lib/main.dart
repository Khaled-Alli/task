import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task/data/local_storage/local_storage.dart';
import 'package:task/presentation/screens/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'presentation/screens/add_product.dart';
import '/utiles/app_router.dart';
import '/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appCubit/appCubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir =await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
 LocaleStorage.productsBox= await Hive.openBox(CACHE_HOME_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit()..getProducts(),
        ),
      ],
      child: Directionality(
        // add this
        textDirection: TextDirection.rtl, // set this property
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Constants.appName,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: Constants.homeRout,
            routes: AppRouter.routs,
          ),
        ),
      ),
    );
  }
}
