import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
        listener: (context, state) {},
    builder: (context, state){
          var cubit = BoatCubit.get(context);
          return Scaffold(
            body:cubit.screens[cubit.currentIndex],
            bottomNavigationBar:GNav(
              gap:8,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              onTabChange:(index)
              {
                 cubit.changeScreen(index);
              },
              padding:const EdgeInsets.all(10),
              tabs:cubit.tabs,
            ),
          );
    }
    );
  }
}
