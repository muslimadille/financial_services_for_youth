import 'package:flutter/cupertino.dart';
import 'package:services_app/modules/home_screen/home_screen.dart';
import 'package:services_app/utils/my_utils.dart';

import '../api_handler/categories_api.dart';
import '../remote/models/categoryModel.dart';
import '../remote/models/paging_model.dart';
import '../remote/models/paging_model.dart';
import '../remote/models/paging_model.dart';
import '../remote/models/staticPagesModel.dart';
import '../remote/my_responce.dart';
import '../utils/apis.dart';

class ServicesProviderModel with ChangeNotifier{
  ///.....ui controllers.........
  bool isLoading=false;
  bool is_pp_active=true;
  String selectedState="أسيوط";
  void setIsLoading(bool value){
    isLoading=value;
    notifyListeners();
  }

  CategoryApi categoryApi=CategoryApi();
  List<Categories> categoriesList=[];
  List<ProviderModel> providersList=[];
  List<StaticPagesModel>staticPagesList=[];
  pagerModel?providerspagerModel;
  getAllCategories(BuildContext context) async {
    categoriesList.clear();
    setIsLoading(true);
    MyResponse<CategoryModel> response =
    await categoryApi.getCategories();
    if (response.status == Apis.CODE_SUCCESS){
      CategoryModel data=response.data as CategoryModel ;
      categoriesList.addAll(data.categories??[]);
      is_pp_active=data.app_status??true;
      setIsLoading(false);
      MyUtils.navigateReplaceCurrent(context, HomeScreen());
    }else if(response.status == Apis.CODE_SUCCESS &&response.data==null){
      setIsLoading(false);
    }else{
      setIsLoading(false);
    }
    notifyListeners();
  }
  getAllProviders(int categoryId,int subCategoryId,String government,int page) async {
    if(page==1) {
      providerspagerModel=null;
      providersList.clear();
      setIsLoading(true);
    }


    MyResponse<pagerModel> response =
    await categoryApi.getProviders( categoryId, subCategoryId, selectedState,page);
    if (response.status == Apis.CODE_SUCCESS){
      if(page>1){
        providerspagerModel=response.data as pagerModel;
        providersList.addAll(providerspagerModel!.data??[]);
        notifyListeners();

      }else{
        providerspagerModel=null;
        providersList.clear();
        providerspagerModel=response.data as pagerModel;
        providersList.addAll(providerspagerModel!.data??[]);
      }

      setIsLoading(false);
    }else if(response.status == Apis.CODE_SUCCESS &&response.data==null){
      setIsLoading(false);
    }else{
      setIsLoading(false);
    }
    notifyListeners();
  }
  getStaticPages() async {
    staticPagesList.clear();
    setIsLoading(true);
    MyResponse<List<StaticPagesModel>> response =
    await categoryApi.getStaticPages();
    if (response.status == Apis.CODE_SUCCESS&&response.data!=null){
      staticPagesList.addAll(response.data??[]);
      setIsLoading(false);
    }else if(response.status == Apis.CODE_SUCCESS &&response.data==null){
      setIsLoading(false);
    }else{
      setIsLoading(false);
    }
    notifyListeners();
  }


}