import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:shop_store/models/home/home_model.dart';
import 'package:shop_store/modules/prouduct_detials/product_detials.dart';
import 'package:shop_store/shared/cubit/cubit.dart';
import 'package:shop_store/shared/styles/colors.dart';

Widget builtDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: Colors.grey,
        height: 1.0,
        width: double.infinity,
      ),
    );
Widget defaultFieldForm({
  required TextEditingController controller,
  required TextInputType keyboard,
  required var valid,
  String? label,
  IconData? prefix,
  //IconData? suffix,
  bool show = true,
  var tap,
  var onchange,
  var onSubmit,
  var suffix,
  var suffixPress,
  var labelStyle,
}) =>
    TextFormField(
      validator: valid,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
          // borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPress,
                color: Colors.white,
              )
            : null,
      ),
      keyboardType: keyboard,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      obscureText: show,
      onTap: tap,
    );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
Widget defButton({
  double width = double.infinity,
  double heigth = 40.0,
  bool isUpper = true,
  Color background = defaultColor,
  Color textColor = Colors.white,
  required var function,
  required String text,
}) =>
    Container(
      height: heigth,
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(color: textColor, fontFamily: 'Jannah'),
        ),
      ),
    );
Widget textButton({
  required String text,
  required var function,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );
void showToast(String message, ToastStates state) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget buildTextForm(
  BuildContext context,
  double height, {
  TextEditingController? buttonController,
  double? width,
  String? title,
  double? fontSize = 16.0,
  Color? color = Colors.black,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: fontSize, color: color),
        ),
        Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 1.0),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: buttonController,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );

Widget builtProductItem(model, context) => InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDetails(
              model: model,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        width: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    color: Colors.white,
                    height: 111,
                    child: Image(
                      image: NetworkImage(model.image!),
                      // height: 111,
                      //fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                model.name!,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.description!,
                maxLines: 1,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '${model.price!}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        BoatCubit.get(context).insertCart(
                            name: model.name,
                            price: model.price.toString(),
                            image: model.image);
                        showToast('Insert', ToastStates.SUCCESS);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple,
                        ),
                        height: 45,
                        width: 40,
                        child: const Icon(
                          Icons.shopping_cart_sharp,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget buildCartItem(Map model, context) => Dismissible(
  key:Key(model['id'].toString()),
  onDismissed:(direction)
  {
    BoatCubit.get(context).deleteCartData(id: model['id']);
  },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,

          height: 166,

          // width: 150,

          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Image(
                  image: NetworkImage('${model['image']}'),
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
                            width: 198,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${model['name']}',
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
                        '${model['price']}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Jannah'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: defButton(
                            function: () {
                              BoatCubit.get(context).sendOrderData();
                              if(BoatCubit.get(context).sendOrder!=null) {
                                showToast('Order ${BoatCubit
                                    .get(context)
                                    .sendMessage!}', ToastStates.SUCCESS);
                              }
                            }, text: 'OrderNow', isUpper: false),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
Widget builtFavoriteItem(Map model, context) => Dismissible(
  key:Key(model['id'].toString()),
  onDismissed:(direction)
  {
    BoatCubit.get(context).deleteFavoriteData(id: model['id']);
  },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,

          height: 166,

          // width: 150,

          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Image(
                  image: NetworkImage('${model['image']}'),
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
                            width: 198,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${model['name']}',
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
                        '${model['price']}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Jannah'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 190,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: defButton(
                            function: () {
                              BoatCubit.get(context).insertCart(
                                  name: model['name'],
                                  price: model['price'],
                                  image: model['image']);
                              BoatCubit.get(context).deleteFavoriteData(id: model['id']);
                              showToast('Insert', ToastStates.SUCCESS);
                            }, text: 'Add Cart', isUpper: false),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
Widget logo(){
  return Stack(
    children: [
      Text(
        'Boat',
        style: GoogleFonts.meddon(
          fontSize: 27.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    ],
  );
}