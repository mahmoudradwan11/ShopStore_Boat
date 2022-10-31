import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/modules/Cart/cart.dart';
import 'package:shop_store/modules/Favorite/favorite.dart';
import 'package:shop_store/modules/contact/contact.dart';
import 'package:shop_store/modules/login/login.dart';
import 'package:shop_store/modules/notification/notification.dart';
import 'package:shop_store/modules/orders/orders.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';
import 'package:shop_store/shared/network/local/cache.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BoatCubit.get(context);
        var scaffoldKey = GlobalKey<ScaffoldState>();
        var formKey = GlobalKey<FormState>();
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        var model = cubit.userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return Scaffold(
          key: scaffoldKey,
          body: Column(
              children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.purple,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('images/pro.jpeg'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cubit.userModel!.data!.name!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              const SizedBox(
                                width: 90,
                              ),
                              IconButton(onPressed:(){
                                scaffoldKey.currentState!.showBottomSheet((context) =>Container(
                                  decoration:BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  height: 290,
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            defaultFieldForm(
                                              show:false,
                                              controller:nameController,
                                              keyboard:TextInputType.name,
                                              valid:(value){
                                                if(value.isEmpty){
                                                  return 'Name Must Not Be Empty';
                                                }
                                                return null;
                                              },
                                              label:'Name',
                                              prefix:Icons.person,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            defaultFieldForm(
                                              show:false,
                                              controller:emailController,
                                              keyboard:TextInputType.emailAddress,
                                              valid:(value){
                                                if(value.isEmpty){
                                                  return 'Email Must Not Be Empty';
                                                }
                                                return null;
                                              },
                                              label:'Email',
                                              prefix:Icons.email,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            defaultFieldForm(
                                              show:false,
                                              controller:phoneController,
                                              keyboard:TextInputType.phone,
                                              valid:(value){
                                                if(value.isEmpty){
                                                  return 'Phone Must Not Be Empty';
                                                }
                                                return null;
                                              },
                                              label:'Phone',
                                              prefix:Icons.mobile_friendly,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            defButton(function:(){
                                              if(formKey.currentState!.validate()){
                                                cubit.updateUserData(
                                                  name:nameController.text,
                                                  email:emailController.text,
                                                  phone:phoneController.text,
                                                );
                                              }
                                            }, text:'Update')
                                          ],
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                                );
                              }, icon:const Icon(Icons.edit,size: 30,color: Colors.white,))
                            ],
                          ),
                          Text(
                            cubit.userModel!.data!.email!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          const Text(
                            'Orders',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context,const Orders());
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      //height: 700,
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          const Text(
                            'Notification',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context,const NotificationScreen());
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      //height: 700,
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          const Text(
                            'Contact Us',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context,Contact());
                                },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      //height: 700,
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          const Text(
                            'Cart',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context, const Cart());
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      //height: 700,
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          const Text(
                            'Favorites',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                navigateTo(context, const Favorite());
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                      //height: 700,
                    ),
                    const Spacer(),
                    defButton(function:(){
                      CacheHelper.removeData(key: 'token').then((value) {
                      if (value) {
                      navigateAndFinish(context, Login());
                      }
                      });
                    }, text:'Logout',background: Colors.grey[100]!,textColor: Colors.purple)
                  ]),
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}
