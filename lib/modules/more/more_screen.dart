import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:services_app/modules/base_screen/base_screen.dart';
import 'package:services_app/modules/more/static_page.dart';
import 'package:services_app/modules/sevices_screen/service_details_screen.dart';
import 'package:services_app/utils/my_utils.dart';
import 'package:services_app/utils/widgets/loading_widget.dart';

import '../../providers/services_provider.dart';
import '../../utils/baseDimentions.dart';
import '../../utils/base_text_style.dart';
import '../../utils/my_colors.dart';
import '../../utils/widgets/transition_image.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  ServicesProviderModel?servicesProviderModel=ServicesProviderModel();

  @override
  void initState() {
    super.initState();
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);
    servicesProviderModel!.getStaticPages();
  }
  @override
  Widget build(BuildContext context) {
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: true);
    return BaseScreen(body: _body());
  }
  Widget _body(){
    return Stack(children: [
      Container(
        child: Column(children:  [
          _header(context),
          Expanded(child: _itemsList())
        ],),
      ),
      //searchProvider!.isLoading?LoadingProgress():Container()
    ],);
  }
  Widget _header(BuildContext ctx){
    return Container(
      height: D.default_80,
      child: Stack(children: [
        TransitionImage("assets/images/header_bg.png",
          width: MediaQuery.of(context).size.width,
          height: D.default_80,
          fit: BoxFit.fill,),
        Container(
          padding: EdgeInsets.only(top:D.default_20,left:D.default_30,right:D.default_30),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("المزيد",style: S.h1(color: Colors.white),textAlign: TextAlign.center,)),
                ],),
            ],
          ),)
      ],),);

  }


  Widget _itemsList(){
    return servicesProviderModel!.isLoading?Center(child: SpinKitCircle(
      color: C.BLUE_1,
      size: D.default_50,
    ),):servicesProviderModel!.staticPagesList.isNotEmpty?ListView.builder(
        itemCount:servicesProviderModel!.staticPagesList.length ,
        itemBuilder:(context,index){
          return _listItem(index);
        }):_noData();
  }

  Widget _listItem(int index){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
      padding: EdgeInsets.only(top: D.default_20,bottom: D.default_20,left: D.default_20,right: D.default_20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: Colors.white,
          boxShadow: [BoxShadow(
              color: C.BLUE_1.withOpacity(0.1),
              offset:Offset(1,1),
              blurRadius:2,
              spreadRadius: 2
          )]
      ),
      child: InkWell(
        onTap:(){
          MyUtils.navigate(context, StaticScreen(servicesProviderModel!.staticPagesList[index]));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.radio_button_checked,size: D.default_20,color: C.BLUE_1,),
            Container(color: Colors.white,width: D.default_1,margin: EdgeInsets.only(top:D.default_5,bottom: D.default_5,left: D.default_5,right: D.default_5),),
            Expanded(child: Text(servicesProviderModel!.staticPagesList[index].pageName??'',style: S.h4(color: C.GREY_3),))
          ],),),
    );
  }
  Widget _noData(){
    return Center(child: Text("لا يوجد خدمات متاحة",style: S.h2(color: C.BLUE_1),),);
  }


}
