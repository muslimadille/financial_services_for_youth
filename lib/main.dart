import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:services_app/modules/splash_screen/splash_screen.dart';
import 'providers/services_provider.dart';
import 'utils/my_colors.dart';
typedef dynamic OnItemClickListener();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ServicesProviderModel>(create: (ctx) => ServicesProviderModel(),),
  ],
    child:EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
        path: 'assets/strings', // <-- change the path of the translation files
        fallbackLocale: Locale('ar', 'EG'),
        child: MyApp()
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale("ar","EG"));
    return MaterialApp(
      theme: ThemeData(
          primaryColor:C.BLUE_1,
          focusColor:C.BLUE_1

      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale:const Locale("ar","EG"),
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.black.withOpacity(0.7),
          ),
          child: const SplashScreen()) ,
    );
  }
}

