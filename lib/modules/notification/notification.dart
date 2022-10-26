import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/models/notifaction/notifaction_model.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit= BoatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notification'),
              centerTitle: true,
            ),
            body:ListView.separated(
                itemBuilder:(context,index)=>buildNotification(cubit.notificationModel!.data!.data![index]),
                separatorBuilder:(context,index)=>const SizedBox(height: 10,),
                itemCount:cubit.notificationModel!.data!.data!.length,
            ),
          );
        });
  }

  Widget buildNotification(NotificationData model) => Container(
    color: Colors.grey[100],
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        title: Text(
          model.title!,
          style: const TextStyle(
            fontFamily: 'Jannah',
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          ListTile(
            title: Text(
              model.message!
            ),
          ),
        ],
      ),
    ),
  );
}
