import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/models/search/search_model.dart';
import 'package:shop_store/modules/prouduct_detials/product_detials.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BoatCubit.get(context);
          if (cubit.searchModel == null ||
              cubit.searchModel!.data!.data!.isEmpty) {
            return const Scaffold(
                body: Center(
              child: Image(image: AssetImage('images/search.png')),
            ));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Search'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildSearchItem(
                          cubit.searchModel!.data!.data![index], context),
                      separatorBuilder: (context, index) => builtDivider(),
                      itemCount: cubit.searchModel!.data!.data!.length,
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget buildSearchItem(SearchData model, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ProductDetails(
                model: model,
              ));
        },
        child: Container(
          color: Colors.white,
          height: 170,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  height: 150,
                  width: 110,
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 210,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    model.name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Jannah'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Jannah'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 98,
                          ),
                          IconButton(
                              onPressed: () {
                                BoatCubit.get(context).insertCart(name:model.name!, price:model.price.toString(), image:model.image!);
                                showToast('Added Cart',ToastStates.SUCCESS);
                              },
                              icon: const Icon(
                                Icons.shopping_cart_rounded,
                                color: Colors.purple,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {
                                BoatCubit.get(context).insertFavorite(name:model.name!, price:model.price.toString(), image:model.image!);
                                showToast('Added Favorite',ToastStates.SUCCESS);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.grey,
                                size: 30,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
