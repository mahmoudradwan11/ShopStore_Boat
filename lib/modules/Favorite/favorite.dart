import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<BoatCubit, BoatStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = BoatCubit.get(context);
        var favorite = cubit.favorites;
        if (favorite.isEmpty) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Cart'),
              ),
              body:const Center(
            child: Image(image: AssetImage('images/favo.png'),),
              ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorite'),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) =>
                    builtFavoriteItem(favorite[index], context),
                separatorBuilder: (context, index) => builtDivider(),
                itemCount: favorite.length
            ),
          );
        }
      }
    );
  }
}
