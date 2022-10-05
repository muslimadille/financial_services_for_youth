


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:services_app/modules/home_screen/home_screen.dart';
import 'package:services_app/utils/my_utils.dart';

import '../../utils/baseDimentions.dart';
import '../../utils/my_colors.dart';

class BaseScreen extends StatefulWidget {
  Widget body;
  bool hideBottomBar;
  BaseScreen({required this.body,this.hideBottomBar=false});


  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with TickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale("ar","EG"));
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(child: Column(
        
        children: [
          Expanded(child: Container(
            color: Colors.white,
            child: widget.body,)),
          widget.hideBottomBar?Container(): Container(
            color: Colors.white,
            child: Stack(
            alignment:AlignmentDirectional.bottomCenter,
            children: [
         Container(
          width: MediaQuery.of(context).size.width,
          height: D.default_60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(D.default_20),topLeft: Radius.circular(D.default_20)),
              color:C.BLUE_1,
              boxShadow: [BoxShadow(
                  color: C.BLUE_1.withOpacity(0.1),
                  offset:Offset(0,0),
                  blurRadius:2,
                  spreadRadius: 2
              )]
          )
          ,),
        Container(
          width: D.default_80,
          height: D.default_80,
          margin: EdgeInsets.only(bottom: D.default_20),
          padding: EdgeInsets.all(D.default_10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_150),
              color:Colors.white,

          ),
          child: Container(
            width: D.default_70,
            height: D.default_70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_150),
              color:C.BLUE_1,
                boxShadow: [BoxShadow(
                    color: C.BLUE_1.withOpacity(0.3),
                    offset:Offset(0,0),
                    blurRadius:2,
                    spreadRadius: 2
                )]

            ),
            child: Center(child: IconButton(
            onPressed: (){
              MyUtils.navigateAsFirstScreen(context, HomeScreen());
            },
            icon: Icon(Icons.home_outlined,color: Colors.white,size: D.default_30,),),),)
          ,),
      ],),)

      ],),),
      resizeToAvoidBottomInset: true,
    );
  }

}
