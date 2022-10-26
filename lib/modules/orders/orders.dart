import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/models/order/orders_model.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BoatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Orders'),
              centerTitle: true,
            ),
            body: ListView.separated(
                itemBuilder: (context, index) => buildOrderItem(cubit.orderModel!.data!.data![index],context),
                separatorBuilder:(context,index)=>builtDivider(),
                itemCount: cubit.orderModel!.data!.data!.length
            ),
          );
        }
    );
  }
  Widget buildOrderItem(OrderData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30)),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(model.date!),
            Spacer(),
            MaterialButton(onPressed:(){
              BoatCubit.get(context).cancelOrder(model.id!);
              showToast('Deleted',ToastStates.SUCCESS);
            },child:const Text('Cancel'),)
          ],
        ),
      ),
    ),
  );
}
