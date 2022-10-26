import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/cubit/states.dart';
import 'package:shop_store/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  var model;
  var boardController = PageController();
  ProductDetails({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoatCubit, BoatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BoatCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 280,
                        color: Colors.white,
                        child: PageView.builder(
                          itemBuilder: (context, index) => Container(
                            height: 200,
                            child: Image(
                              //height:100,
                              image: NetworkImage(model!.images![index]),
                            ),
                          ),
                          itemCount: model!.images!.length,
                          controller: boardController,
                        ),
                      ),
                      IconButton(onPressed:(){
                        cubit.insertFavorite(name:model.name, price:model.price.toString(), image:model.image);
                        showToast('Added Favorite',ToastStates.SUCCESS);
                      }, icon:const Icon(Icons.favorite_border,color: Colors.grey,size:30,)),
                      Positioned(
                        top: 0,
                        left: 0,
                          child: IconButton(onPressed:(){
                            cubit.insertCart(name:model.name, price:model.price.toString(), image:model.image);
                            showToast('Added Cart',ToastStates.SUCCESS);
                          }, icon:const Icon(Icons.shopping_cart_sharp,color: Colors.purple,size: 30,)))
                    ],
                  ),
                  Center(
                    child: SmoothPageIndicator(
                        effect: JumpingDotEffect(
                          dotColor: Colors.purpleAccent[100]!,
                          activeDotColor: defaultColor,
                          dotHeight: 12,
                          dotWidth: 12,
                          // expansionFactor: 4,
                          spacing: 5.0,
                        ),
                        controller: boardController,
                        count: model!.images!.length),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(model!.name!,style:const TextStyle(fontSize: 15)),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('\$${model.price}',style:const TextStyle(fontSize: 18,color:defaultColor),),
                      const Spacer(),
                      if(model.discount!=0)
                        Text('${model.oldPrice}',style:const TextStyle(fontSize: 18,color:Colors.grey,decoration: TextDecoration.lineThrough),)
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ExpansionTile(
                      title: const Text(
                        'Product Detail',
                        style: TextStyle(
                            fontFamily: 'Jannah',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            model.description,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontFamily: 'Jannah',
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children:const [
                      Text('Rate',style: TextStyle(fontSize:20),),
                      Spacer(),
                      Icon(Icons.star,color: Colors.yellow,size:30,),
                      Icon(Icons.star,color: Colors.yellow,size:30,),
                      Icon(Icons.star,color: Colors.yellow,size:30,),
                      Icon(Icons.star,color: Colors.yellow,size:30,),
                      Icon(Icons.star,color: Colors.grey,size:30,)
                    ],
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  const Text('Suggest For you',style: TextStyle(fontSize: 20),),
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
          ),
        );
      },
    );
  }
}
