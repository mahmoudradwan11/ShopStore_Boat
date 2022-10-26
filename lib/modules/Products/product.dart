import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/models/cateogry/ccateogry_model.dart';
import 'package:shop_store/modules/search/search.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  var searchController = TextEditingController();
  ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BoatCubit.get(context);
        if (cubit.homeModel == null) {
          return const Center(
              child: Text(
            'Products',
            style: TextStyle(fontFamily: 'Jannah'),
          ));
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Products'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          height: 55,
                          child: Center(
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search Store',
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: Colors.black,
                                  )
                              ),
                              onSubmitted:(value){
                                cubit.search(value);
                                navigateTo(context,const SearchScreen());
                              },
                            ),
                          ),
                        ),
                      ),
                      const Text('Category',style: TextStyle(fontSize: 20),),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        child: ListView.separated(
                          //physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildCate(cubit.categoryModel!.data!.data![index],index,context),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                          itemCount: cubit.categoryModel!.data!.data!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Exclusive Offers',style: TextStyle(fontSize:20),),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 296,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => builtProductItem(
                                cubit.homeModel!.data!.exclusive![index],
                                context),
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: cubit.homeModel!.data!.exclusive!.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('For you',style: TextStyle(fontSize: 20),),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 296,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => builtProductItem(
                                cubit.homeModel!.data!.forYou![index], context),
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: cubit.homeModel!.data!.forYou!.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Daily Offers',style: TextStyle(fontSize: 20),),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 296,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => builtProductItem(
                                cubit.homeModel!.data!.products![index], context),
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: cubit.homeModel!.data!.products!.length),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('BestSeller',style: TextStyle(fontSize: 20),),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 296,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => builtProductItem(
                                cubit.homeModel!.data!.bestSeller![index],
                                context),
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 15,
                                ),
                            itemCount: cubit.homeModel!.data!.bestSeller!.length),
                      ),
                    ],
                  ),
                ),
              ));
        }
      },
    );
  }

  //Widget buildProductItem(Products model) => Column(
    //    children: [
     //     Text(model.name!),
      //    const SizedBox(
      //      height: 20,
      //    ),
     //     Text('${model.price}')
        //],
      //);
  Widget buildCate(CateData model,index,context)=>Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color:BoatCubit.get(context).containerColor[index],
    ),
    width: 340,
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(image:NetworkImage(model.image!),width: 100,),
          const SizedBox(width: 10,),
          Text(model.name!,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
        ],
      ),
    ),
  );
}
