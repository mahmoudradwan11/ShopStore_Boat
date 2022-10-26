import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<BoatCubit, BoatStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = BoatCubit.get(context);
        var cart = cubit.cart;
        if (cart.isEmpty) {
          return Scaffold(
              appBar: AppBar(
              title: const Text('Cart'),
        ),
        body:const Center(
            child: Image(image: AssetImage('images/cart_empty.png'),),
          ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) =>
                    buildCartItem(cart[index], context),
                separatorBuilder: (context, index) => builtDivider(),
                itemCount: cart.length
            ),
          );
        }
      }
    );
  }
}
