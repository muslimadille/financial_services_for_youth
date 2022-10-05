import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:services_app/modules/base_screen/base_screen.dart';
import 'package:services_app/modules/sevices_screen/service_details_screen.dart';
import 'package:services_app/utils/my_utils.dart';
import 'package:services_app/utils/widgets/loading_widget.dart';
import 'package:flutter_html/flutter_html.dart';


import '../../providers/services_provider.dart';
import '../../remote/models/staticPagesModel.dart';
import '../../utils/baseDimentions.dart';
import '../../utils/base_text_style.dart';
import '../../utils/my_colors.dart';
import '../../utils/widgets/transition_image.dart';

class StaticScreen extends StatefulWidget {
  StaticPagesModel staticPagesModel;
  StaticScreen(this.staticPagesModel,{Key? key}) : super(key: key);

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(body: _body());
  }
  Widget _body(){
    return Stack(children: [
      Container(
        child: Column(children:  [
          _header(context),
          Expanded(child: SingleChildScrollView(child: Html(
            shrinkWrap:true,
            data:widget.staticPagesModel.content ,
            style: {
              "body": Style(
                fontFamily: "Cairo",
                fontSize:FontSize.small,
                fontWeight: FontWeight.normal,
                color: C.GREY_3,),
            },
          ),))
        ],),
      ),
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
                  Expanded(child: Text(widget.staticPagesModel.pageName??'',style: S.h1(color: Colors.white),textAlign: TextAlign.center,)),
                ],),
            ],
          ),)
      ],),);

  }






}
