import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_app/modules/base_screen/base_screen.dart';
import 'package:services_app/utils/base_text_style.dart';
import 'package:services_app/utils/my_utils.dart';
import 'package:services_app/utils/widgets/transition_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../providers/services_provider.dart';
import '../../utils/baseDimentions.dart';
import '../../utils/my_colors.dart';
import '../more/more_screen.dart';
import '../sevices_screen/services_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServicesProviderModel?servicesProviderModel=ServicesProviderModel();
  List<String> items = [
    'أسيوط',
    'سوهاج',
  ];
  @override
  void initState() {
    super.initState();
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: false);

  }
  @override
  Widget build(BuildContext context) {
    servicesProviderModel=Provider.of<ServicesProviderModel>(context,listen: true);
    return BaseScreen(
      body: Column(
        children: [_header(context),
          _statePart(),
          Expanded(child: _body())],
      ),
    );
  }

  Widget _body() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _cartItem(
            "خدمات مالية", "assets/images/mony_serv.png", onFinanceClicked),
        _cartItem("خدمات غير مالية", "assets/images/no_mony_serv.png",
            onNonFinanceClicked)
      ],
    ));
  }

  Widget _cartItem(String title, String icon, Function onclick) {
    return InkWell(
      onTap: () {
        onclick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.25,
        margin: EdgeInsets.all(D.default_10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(D.default_10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: C.BLUE_1.withOpacity(0.1),
                  offset: Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 3)
            ]),
        child: Column(
          children: [
            Expanded(
                child: TransitionImage(
              icon,
              fit: BoxFit.fitWidth,
              width: D.default_70,
              height: D.default_70,
            )),
            Container(
              margin: EdgeInsets.only(
                  left: D.default_10,
                  right: D.default_10,
                  bottom: D.default_20),
              child: Center(
                child: Text(
                  title,
                  style: S.h3(color: C.BLUE_1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onFinanceClicked() {
    MyUtils.navigate(context, ServicesScreen(0));
  }

  void onNonFinanceClicked() {
    MyUtils.navigate(context, ServicesScreen(1));
  }

  Widget _header(BuildContext ctx) {
    return Container(
      height: D.default_80,
      child: Stack(
        children: [
          TransitionImage(
            "assets/images/header_bg.png",
            width: MediaQuery.of(context).size.width,
            height: D.default_80,
            fit: BoxFit.fill,
          ),
          Container(
            padding: EdgeInsets.only(
                top: D.default_20, left: D.default_30, right: D.default_30),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      "الرئيسية",
                      style: S.h1(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _statePart() {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: D.default_70,
      margin: EdgeInsets.only(top:D.default_50,left: D.default_30,right: D.default_30),
      padding: EdgeInsets.only(top:D.default_10,bottom:D.default_10,left: D.default_20,right: D.default_20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(D.default_10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: C.BLUE_1.withOpacity(0.1),
                offset: Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 3)
          ]),
      child: Row(children: [
        Icon(Icons.radio_button_checked,size: D.default_20,color: C.BLUE_1,),
        Container(color: Colors.white,width: D.default_1,margin: EdgeInsets.only(top:D.default_5,bottom: D.default_5,left: D.default_5,right: D.default_5),),
        _stateSpinner(),
        Expanded(child: Container()),
        IconButton(onPressed: (){
          MyUtils.navigate(context, MoreScreen());
        }, icon: Icon(Icons.menu,color: C.BLUE_1,))
      ],),
    );
  }
  Widget _stateSpinner(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: items
            .map((item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: S.h4(color: C.GREY_3),
              ),
            ))
            .toList(),
        value: servicesProviderModel!.selectedState,
        onChanged: (value) {
          setState(() {
            servicesProviderModel!.selectedState = value as String;
          });
        },
        buttonHeight: D.default_40,
        buttonWidth: D.default_100,
        itemHeight: D.default_40,
      ),
    );
  }
}
