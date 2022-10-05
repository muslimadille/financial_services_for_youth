import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_app/modules/base_screen/base_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../providers/services_provider.dart';
import '../../remote/models/paging_model.dart';
import '../../utils/baseDimentions.dart';
import '../../utils/base_text_style.dart';
import '../../utils/my_colors.dart';
import '../../utils/widgets/transition_image.dart';

class ServiceDetailsScreen extends StatefulWidget {
  ProviderModel providerModel;
  ServiceDetailsScreen(this.providerModel,{Key? key}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  ServicesProviderModel?servicesProviderModel=ServicesProviderModel();
  int selectedTap=0;
@override
  void initState() {
    super.initState();
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);

}


  @override
  Widget build(BuildContext context) {
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);
    return BaseScreen(body: _body());
  }
  Widget _body(){
    return Stack(children: [
      _header(context),
      Container(
        margin: EdgeInsets.only(top: D.default_100),
        child: Column(children:  [
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            margin: EdgeInsets.only(top: D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
            padding: EdgeInsets.only(top: D.default_15,bottom: D.default_15,left: D.default_20,right: D.default_20),
            decoration: BoxDecoration(
                border: Border.all(color: C.BLUE_1),

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

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(child: Text(widget.providerModel.name??"",style:S.h3(color: C.GREY_1) ,)),
                        _locatonBtn()
                      ],),
                      SizedBox(height: D.default_10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Icon(Icons.location_on,color: C.BLUE_1,size: D.default_20,),
                        Expanded(child: Text(widget.providerModel.address??"",style:S.h5(color: C.GREY_1) ,))
                      ],),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Icon(Icons.phone_android,color: C.BLUE_1,size: D.default_20,),
                        Expanded(child: Text(widget.providerModel.phone??"",style:S.h5(color: C.GREY_1)) ,)
                      ],),
                    ],)),


                  ],),
                Wrap(alignment: WrapAlignment.start,
                  children: [
                  _locationItem("${"محافظة"} ${widget.providerModel.government??""}"),
                  _locationItem("${"مدينة"} ${widget.providerModel.city??''}"),
                ],)

              ],),),
          ),
          Expanded(child: _dataList())
        ],),
      ),
      //searchProvider!.isLoading?LoadingProgress():Container()
    ],);
  }
  Widget _locationItem(String title){
    return Container(
      margin: EdgeInsets.only(top:D.default_10,left: D.default_10,right: D.default_10),
      padding: EdgeInsets.all(D.default_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: Colors.white,
          border: Border.all(color: C.BLUE_1),
          boxShadow: [BoxShadow(
              color: C.BLUE_1.withOpacity(0.1),
              offset:Offset(1,1),
              blurRadius:2,
              spreadRadius: 2
          )]
      ),
      child: Text(title,style: S.h5(color: C.GREY_1),),);
  }
  Widget _header(BuildContext ctx){
    return Container(
      height: D.default_80,
      child: Stack(
        alignment:AlignmentDirectional.bottomCenter,
        clipBehavior: Clip.none,
        children: [
        TransitionImage("assets/images/header_bg.png",
          width: MediaQuery.of(context).size.width,
          height: D.default_150,
          fit: BoxFit.fill,),
        Container(
          padding: EdgeInsets.only(top:D.default_20,left:D.default_30,right:D.default_30),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Text("تفاصيل الخدمة",style: S.h1(color: Colors.white),textAlign: TextAlign.center,)),
                ],),
            ],
          ),),
      ],),);

  }
Widget _locatonBtn(){
    return InkWell(
      onTap: (){
        openMap();
      },
      child: Container(
      width: D.default_120,
      height: D.default_35,
      padding: EdgeInsets.only(left: D.default_10,right: D.default_10,top: D.default_5,bottom: D.default_5),
      decoration: BoxDecoration(
          color: C.BLUE_1,
          borderRadius: BorderRadius.circular(D.default_10),
          boxShadow:[BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset:Offset(2,2),
              blurRadius:2,
              spreadRadius: 0.5
          )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.share_location,color: Colors.white,size: D.default_20,),
          Text("الذهاب للموقع",style: S.h5(color: Colors.white),),

        ],),
    ),);
}
  Widget _dataList(){
    return Container(
      margin: EdgeInsets.only(top: D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
      padding: EdgeInsets.only(top:D.default_10,bottom: D.default_10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          border: Border.all(color: C.BLUE_1),
          color: Colors.white,
          boxShadow: [BoxShadow(
              color: C.BLUE_1.withOpacity(0.1),
              offset:Offset(1,1),
              blurRadius:2,
              spreadRadius: 2
          )]
      ),
      child: SingleChildScrollView(child: Column(children: itemsList(),),),);
  }
  Widget _listItem(String title,String discription){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
      child: InkWell(
        onTap:(){

        },
        child:Column(children: [
          Row(children: [
            Icon(Icons.radio_button_checked,size: D.default_20,color: C.BLUE_1,),
            Container(color: Colors.white,width: D.default_1,margin: EdgeInsets.only(top:D.default_5,bottom: D.default_5,left: D.default_5,right: D.default_5),),
            Text("${title}",style:S.h4(color: C.GREY_1) ,)
          ],),
          Container(
            margin: EdgeInsets.only(top:D.default_10,left: D.default_10,right: D.default_20),
            padding: EdgeInsets.all(D.default_10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(D.default_10),
                color: Colors.white,
                border: Border.all(color: C.BLUE_1),
                boxShadow: [BoxShadow(
                    color: C.BLUE_1.withOpacity(0.1),
                    offset:Offset(1,1),
                    blurRadius:2,
                    spreadRadius: 2
                )]
            ),
            child: Text(discription,style: S.h4(color: C.GREY_1),),)
          
        ],),),
    );
  }
List<Widget> itemsList(){
    List<Widget>data=[];
    for(int i=0;i<widget.providerModel.getFeatures!.length;i++){
      data.add(_listItem(widget.providerModel.getFeatures![i].key??'',widget.providerModel.getFeatures![i].value??""),);
    }
    return data;
}

   Future<void> openMap() async {
  if(getLatLng().isNotEmpty){
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${getLatLng().split(",")[0]},${getLatLng().split(",")[1]}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      await Fluttertoast.showToast(msg: "الموقع غير متاح");
    }
  }else{
    String mapUrl = widget.providerModel.location??"";
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      await Fluttertoast.showToast(msg: "الموقع غير متاح");
    }
  }

  }
  String getLatLng(){
    String mapUrl = widget.providerModel.location??"";
    if(mapUrl.contains("/@")){
      String url = mapUrl.split('@')[1];
      String at = url.split('z')[0];
      String lat = at.split(',')[0];
      String lon = at.split(',')[1];
      String zoom=at.split(',')[2];

      return "${lat},${lon},${zoom}";
    }else{
      return"";
    }

  }

}
