import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../providers/services_provider.dart';
import '../../utils/baseDimentions.dart';
import '../../utils/base_text_style.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_utils.dart';
import '../../utils/widgets/transition_image.dart';
import '../base_screen/base_screen.dart';
import '../home_screen/home_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ServicesProviderModel?servicesProviderModel=ServicesProviderModel();


  @override
  void initState() {
    super.initState();
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);
    _timerNavigation();
    return BaseScreen(
      hideBottomBar: true,
        body: Stack(
      alignment:AlignmentDirectional.center,
      children: [

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          TransitionImage(
            "assets/images/mitLogo.png",
            fit: BoxFit.fitWidth,
            width: D.default_300*2,
            height: D.default_200,
          ),
          Text("دليل الخدمات المالية وغير المالية",style: S.h2(color: C.BLUE_1),),
          SizedBox(height: D.default_20,),
          SpinKitCircle(
            color: C.BLUE_1,
            size: D.default_50,
          ),
        ],)
      ],
    ));
  }
  void _timerNavigation(){
    if(mounted) {
      Future.delayed(Duration(milliseconds: 3000)).then((value) {
        servicesProviderModel!.getAllCategories(context);
      });
    }

  }

}
