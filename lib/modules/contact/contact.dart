import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';
class Contact extends StatelessWidget{
  Contact({Key? key}) : super(key: key);
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
        listener: (context, state) {},
    builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Contact Us',),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTextForm(
              context,
              buttonController: descriptionController,
              title: 'Problem',
              MediaQuery.of(context).size.height * 0.22,
            ),
            const Spacer(),
            defButton(function:(){
              BoatCubit.get(context).sendContact(descriptionController.text);
              showToast('Send',ToastStates.SUCCESS);
            }, text:'Send'),
          ],
        ),
      ),
    );
    }
    );
  }
}
