import 'package:shop_store/models/login/login_model.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
abstract class BoatStates {}
class InitialState extends BoatStates{}
class ChangeScreenIndex extends BoatStates{}
class GetProductData extends BoatStates{}
class GetErrorProductData extends BoatStates{}
class GetCateData extends BoatStates{}
class GetErrorCateData extends BoatStates{}
class SearchLoadingState extends BoatStates {}
class SearchSuccessState extends BoatStates {}
class SearchErrorState extends BoatStates{}
class CreateDatabaseState extends BoatStates {}
class ErrorCreateDatabaseState extends BoatStates {}
class InsertCartState extends BoatStates {}
class ErrorInsertCartState extends BoatStates {}
class GetCartState extends BoatStates {}
class ErrorCartState extends BoatStates {}
class InsertFavoriteState extends BoatStates {}
class ErrorFavoriteInsertDataState extends BoatStates {}
class GetFavoriteDataState extends BoatStates {}
class ErrorGetFavoriteDataState extends BoatStates {}
class DeleteCartDataState extends BoatStates {}
class DeleteFavoriteDataState extends BoatStates {}
class SendOrderDataState extends BoatStates{}
class ErrorSentOrderDataState extends BoatStates{}
class UserDataSuccessState extends BoatStates{
  LoginModel? userModel;
  UserDataSuccessState(this.userModel);
}
class UserDataFailedState extends BoatStates{}
class GetOrders extends BoatStates{}
class ErrorGetOrders extends BoatStates{}
class CancelOrders extends BoatStates{}
class ErrorCancelOrders extends BoatStates{}
class GetNotification extends BoatStates{}
class ErrorGetNotification extends BoatStates{}
class SendContact extends BoatStates{}
class ErrorContact extends BoatStates{}
class UserUpdateSuccessState extends BoatStates{
  LoginModel? userModel;
  UserUpdateSuccessState(this.userModel);
}
class UserUpdateFailedState extends BoatStates{}

