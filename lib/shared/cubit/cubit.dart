import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_store/models/cancel_order/cancel_order.dart';
import 'package:shop_store/models/cateogry/ccateogry_model.dart';
import 'package:shop_store/models/home/home_model.dart';
import 'package:shop_store/models/login/login_model.dart';
import 'package:shop_store/models/notifaction/notifaction_model.dart';
import 'package:shop_store/models/order/orders_model.dart';
import 'package:shop_store/models/search/search_model.dart';
import 'package:shop_store/models/send_order/send_order_model.dart';
import 'package:shop_store/modules/Account/account.dart';
import 'package:shop_store/modules/Cart/cart.dart';
import 'package:shop_store/modules/Favorite/favorite.dart';
import 'package:shop_store/modules/Products/product.dart';
import 'package:shop_store/shared/cubit/states.dart';
import 'package:shop_store/shared/network/end/points.dart';
import 'package:shop_store/shared/network/remote/dio_helper.dart';
import 'package:sqflite/sqflite.dart';
class BoatCubit extends Cubit<BoatStates>
{
  BoatCubit():super(InitialState());
  static BoatCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  int currentIndex = 0;
  List<Widget>screens =[
    ProductsScreen(),
    const Cart(),
    const Favorite(),
    const Account(),
  ];
  List<Color> containerColor = const [
    Color.fromRGBO(83, 177, 117, .6),
    Color.fromRGBO(248, 164, 76, .6),
    Color.fromRGBO(211, 176, 224, .6),
    Color.fromRGBO(200, 103, 130,.6),
    Color.fromRGBO(200, 230, 200,.6),
  ];
  List<GButton> tabs =const [
    GButton(icon:Icons.home,text: 'Home',),
    GButton(icon:Icons.shopping_cart,text: 'Cart',),
    GButton(icon:Icons.favorite,text: 'Favorite',),
    GButton(icon:Icons.person,text: 'Account',),
  ];
  void changeScreen(index)
  {
     currentIndex = index;
     emit(ChangeScreenIndex());
  }
  void getHomeData()
  {
    DioHelper.getData(url:HOME,token: token).then((value){
      homeModel = HomeModel.fromJson(value.data);
      print('Price = ${homeModel!.data!.products![0].price}');
      print('Image = ${homeModel!.data!.products![0].images![0]}');
      print('Name  = ${homeModel!.data!.products![0].name}');
      print('Image1 = ${homeModel!.data!.products![0].images![1]}');
      print('Products length = ${homeModel!.data!.products!.length}');
      print('BestSeller length = ${homeModel!.data!.bestSeller!.length}');
      print('Exclusive length = ${homeModel!.data!.exclusive!.length}');
      print('ForYou length = ${homeModel!.data!.forYou!.length}');


      emit(GetProductData());
    }).catchError((error){
      print(error.toString());
      emit(GetErrorProductData());
    });
  }
  CategoryModel? categoryModel;
  void getCategory(){
    DioHelper.getData(url:CATEGORY).then((value){
      categoryModel = CategoryModel.fromJson(value.data);
      print('NameCate  = ${categoryModel!.data!.data![0].name}');
      emit(GetCateData());
    }).catchError((error){
      print(error.toString());
      emit(GetErrorCateData());
    });
  }
  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print("error occur:${error.toString()}");
      emit(SearchErrorState());
    });
  }
  Database? database;
  List<Map> cart = [];
  List<Map> favorites = [];
  void createDatabase() {
    openDatabase('Boat.db', version: 2, onCreate: (database, version) {
      print('DataBase Created');
      database
          .execute(
          'create table Cart(id INTEGER PRIMARY KEY,name TEXT ,price TEXT,image TEXT)')
          .then((value) {
        print('Table 1 Created');
      }).catchError((error) {
        print('Error occur : $error');
      });
      database
          .execute(
          'create table Favorite(id INTEGER PRIMARY KEY,name TEXT ,price TEXT,image TEXT)')
          .then((value) {
        print('Table 2 Created');
      }).catchError((error) {
        print('Error occur : $error');
      });
    }, onOpen: (database) {
      getCartData(database);
      getFavoriteData(database);
      print('Database opened');
    }).then((value) {
      database = value;
      emit(CreateDatabaseState());
    }).catchError((error) {
      emit(ErrorCreateDatabaseState());
    });
  }

  Future<void> insertCart(
      { required String name,
        required String price,
        required String image}) async {
    database!.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO Cart(name,price,image) VALUES("$name","$price","$image")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(InsertCartState());
        getCartData(database);
      }).catchError((error) {
        print('Error occur : $error');
        emit(ErrorInsertCartState());
      });
    });
  }

  void getCartData(database) {
    cart = [];
    database!.rawQuery('select * from Cart').then((value) {
      value.forEach((element) {
        cart.add(element);
      });
      print(cart);
      emit(GetCartState());
    }).catchError((error) {
      print('Error occur no data');
      emit(ErrorCartState());
    });
  }

  void deleteCartData({required int id}) async {
    await database!
        .rawDelete('DELETE FROM Cart WHERE id= ?', [id]).then((value) {
      getCartData(database);
      emit(DeleteCartDataState());
    });
  }

  Future<void> insertFavorite(
      {required String name,
        required String price,
        required String image}) async {
    database!.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO Favorite(name,price,image) VALUES("$name","$price","$image")')
          .then((value) {
        print('$value Inserted Successfully');
        emit(InsertFavoriteState());
        getFavoriteData(database);
        //print()
      }).catchError((error) {
        print('Error occur : $error');
        emit(ErrorFavoriteInsertDataState());
      });
    });
  }

  void getFavoriteData(database) {
    favorites = [];
    database!.rawQuery('select * from Favorite').then((value) {
      value.forEach((element) {
        favorites.add(element);
      });
      print(favorites);
      emit(GetFavoriteDataState());
    }).catchError((error) {
      print('Error occur no data');
      emit(ErrorGetFavoriteDataState());
    });
  }

  void deleteFavoriteData({required int id}) async {
    await database!
        .rawDelete('DELETE FROM Favorite WHERE id= ?', [id]).then((value) {
      getFavoriteData(database);
      emit(DeleteFavoriteDataState());
    });
  }
  SendOrder? sendOrder;
  String? sendMessage;
  void sendOrderData()
  {
      DioHelper.postData(url:ORDERS,token: token,data:{
           'address_id':'35',
           'payment_method':'2',
           'use_points':'false'
      }).then((value){
        sendOrder = SendOrder.fromJson(value.data);
        sendMessage = sendOrder!.message!;
        print('Order Message  = ${sendOrder!.message}');
        emit(SendOrderDataState());
      }).catchError((error){
        print(error.toString());
        emit(ErrorSentOrderDataState());
      });
  }
   LoginModel? userModel;
  void getUserData()
  {
    DioHelper.getData(
      url:PROFILE,
      token: token,
    ).then((value) {
      userModel =LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(UserDataSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(UserDataFailedState());
    });
  }
  OrderModel? orderModel;
  void getOrders()
  {
     DioHelper.getData(url:ORDERS,token:token).then(
             (value){
                orderModel = OrderModel.fromJson(value.data);
                print('Orders Length = ${orderModel!.data!.data!.length}');
                emit(GetOrders());
             }
     ).catchError((error){
       print(error.toString());
       emit(ErrorGetOrders());
     });
  }
  CancelOrder? cancelOrders;
  void cancelOrder(int orderID){
    DioHelper.getData(url:'orders/$orderID/cancel',token:token).then((value){
     cancelOrders = CancelOrder.fromJson(value.data);
     emit(CancelOrders());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCancelOrders());
    });
  }
  NotificationModel? notificationModel;
  void getNotification(){
    DioHelper.getData(url:NOTIFICATION,token: token).then((value){
      notificationModel  =NotificationModel.fromJson(value.data);
      print('not = ${notificationModel!.data!.data![0].title}');
      emit(GetNotification());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetNotification());
    });
  }
  void sendContact(String message){
    DioHelper.postData(url:CONTACT, data:{
        'name':userModel!.data!.name!,
        'phone':userModel!.data!.phone,
        'email':userModel!.data!.email,
        'message':message,
    }).then((value){
       emit(SendContact());
    }).catchError((error){
      emit(ErrorContact());
    });
  }
}