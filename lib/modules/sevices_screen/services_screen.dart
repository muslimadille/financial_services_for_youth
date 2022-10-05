import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:services_app/modules/base_screen/base_screen.dart';
import 'package:services_app/modules/sevices_screen/service_details_screen.dart';
import 'package:services_app/utils/my_utils.dart';
import 'package:services_app/utils/widgets/loading_widget.dart';

import '../../providers/services_provider.dart';
import '../../utils/baseDimentions.dart';
import '../../utils/base_text_style.dart';
import '../../utils/my_colors.dart';
import '../../utils/widgets/transition_image.dart';

class ServicesScreen extends StatefulWidget {
  int selectedIndex;
   ServicesScreen(this.selectedIndex,{Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  ServicesProviderModel?servicesProviderModel=ServicesProviderModel();
  int selectedTap=0;
  int _currentLoadedPage=1;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);
    servicesProviderModel!.getAllProviders(
        servicesProviderModel!.categoriesList[widget.selectedIndex].id!,
        servicesProviderModel!.categoriesList[widget.selectedIndex].subCategories![selectedTap].id!,servicesProviderModel!.selectedState,_currentLoadedPage);
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
          Expanded(child: _tabs())
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
                  Expanded(child: Text(widget.selectedIndex==0?"خدمات مالية":"خدمات غير مالية",style: S.h1(color: Colors.white),textAlign: TextAlign.center,)),
                ],),
            ],
          ),)
      ],),);

  }

  Widget _tabs(){
    return Column(
      children:[
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _tapsPart(),
            Expanded(child:servicesProviderModel!.isLoading?Center(child: SpinKitCircle(
              color: C.BLUE_1,
              size: D.default_50,
            ),):SmartRefresher(
              key: _refresherKey,
              controller: _refreshController,
              enablePullUp: true,
              child: _servList(),
              physics: BouncingScrollPhysics(),
              footer: ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
                completeDuration: Duration(milliseconds: 500),
              ),
              onRefresh: () async {
                _currentLoadedPage=1;
                servicesProviderModel!.getAllProviders(
                    servicesProviderModel!.categoriesList[widget.selectedIndex].id!,
                    servicesProviderModel!.categoriesList[widget.selectedIndex].subCategories![selectedTap].id!,servicesProviderModel!.selectedState,_currentLoadedPage);              },
              onLoading: () async {
                _currentLoadedPage=_currentLoadedPage+1;
                await servicesProviderModel!.getAllProviders(
                    servicesProviderModel!.categoriesList[widget.selectedIndex].id!,
                    servicesProviderModel!.categoriesList[widget.selectedIndex].subCategories![selectedTap].id!,servicesProviderModel!.selectedState,_currentLoadedPage);
                _refreshController.loadComplete();
              },
            ))
          ],
        ))]
      ,);
  }
  Widget _servList(){
    return servicesProviderModel!.providersList.isNotEmpty?ListView.builder(
        itemCount:servicesProviderModel!.providersList.length ,
        itemBuilder:(context,index){
          return _listItem(index);
        }):_noData();
  }
  Widget _tapsPart(){
    return Container(
      height: D.default_50,
      margin: EdgeInsets.only(left: D.default_10,right: D.default_10,top: D.default_10,bottom: D.default_10),
      child: ListView.builder(
        scrollDirection:Axis.horizontal,
          itemCount: servicesProviderModel!.categoriesList[widget.selectedIndex].subCategories!.length,
        itemBuilder: (BuildContext context, int index) {
          return _tabBtn(index);
        },
      ),);
  }
  Widget _tabBtn(int index) {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentLoadedPage=1;
            selectedTap=index;
            servicesProviderModel!.getAllProviders(
                servicesProviderModel!.categoriesList[widget.selectedIndex].id!,
                servicesProviderModel!.categoriesList[widget.selectedIndex].subCategories![index].id!,"اسيوط",_currentLoadedPage);;
          });
        },
        child: Container(
          margin: EdgeInsets.only(left:D.default_10,right: D.default_10),
          padding: EdgeInsets.only(
              left: D.default_20,
              right: D.default_20,
              top: D.default_10,
              bottom: D.default_10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(D.default_10),
              border: Border.all(color:C.BLUE_1 ),
              color: selectedTap==index?C.BLUE_1:Colors.white,
              ),
          child: Text(
            servicesProviderModel!.categoriesList[widget.selectedIndex].subCategories![index].name??"",
            style: S.h3(color: selectedTap==index?Colors.white:C.BLUE_1),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  Widget _listItem(int index){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
      padding: EdgeInsets.only(top: D.default_10,bottom: D.default_10,left: D.default_20,right: D.default_20),
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
          MyUtils.navigate(context, ServiceDetailsScreen(servicesProviderModel!.providersList[index]));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 0,
              child: Text( removeSpace(servicesProviderModel!.providersList[index].name??'غير متوفر'),style:S.h3(color: C.GREY_1) ,),),
            SizedBox(height: D.default_10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Icon(Icons.location_on,color: C.BLUE_1,size: D.default_20,),
              Expanded(child: Text(removeSpace(servicesProviderModel!.providersList[index].address??"غير متوفر"),style:S.h5(color: C.GREY_1) ,))
            ],),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Icon(Icons.phone_android,color: C.BLUE_1,size: D.default_20,),
              Expanded(child: Text(removeSpace(servicesProviderModel!.providersList[index].phone??"غير متوفر"),style:S.h5(color: C.GREY_1) ,))
            ],)
          ],),),
    );
  }
  Widget _noData(){
    return Center(child: Text("لا يوجد خدمات متاحة",style: S.h2(color: C.BLUE_1),),);
  }
 String removeSpace(String text){
    return text.replaceAll("  ", "").replaceAll("\n", "") ;
 }

}
