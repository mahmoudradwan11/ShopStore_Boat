import 'package:flutter/material.dart';
import 'package:shop_store/models/boarding/boarding_model.dart';
import 'package:shop_store/modules/login/login.dart';
import 'package:shop_store/shared/components/components.dart';
import 'package:shop_store/shared/network/local/cache.dart';
import 'package:shop_store/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'images/board1.png',
      title: 'BOAT',
      body: 'Welcome in Boat let\'s starting shopping ',
    ),
    BoardingModel(
        image: 'images/board2.png',
        title: 'BOAT',
        body: 'We help people conect with store \naround United State of America'
    ),
    BoardingModel(
      image: 'images/board3.png',
      title: 'BOAT',
      body: 'We show the easy way to shop. \nJust stay at home with us',
    ),
  ];
  var boardController = PageController();
  var isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
         Expanded(
          child: PageView.builder(
            onPageChanged: (int index) {
              if (index == boarding.length - 1) {
                setState(() {
                  isLast = true;
                });
              } else {
                setState(() {
                  isLast = false;
                });
              }
            },
            physics: const BouncingScrollPhysics(),
            controller: boardController,
            itemBuilder: (context, index) =>builtBoardingItem(boarding[index]),
            itemCount: boarding.length,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
          SmoothPageIndicator(
              effect: JumpingDotEffect(
                dotColor: Colors.purpleAccent[100]!,
                activeDotColor: defaultColor,
                dotHeight: 12,
                dotWidth: 12,
               // expansionFactor: 4,
                spacing: 5.0,
              ),
              controller: boardController,
              count: boarding.length),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defButton(function:(){
              submit();
            }, text:'Continue',width:300,heigth: 45,isUpper: false),
          )
        ],
      ),
    );
  }
  void submit()
  {
    CacheHelper.saveData(key:'onBoarding', value:true).then((value){
      if(value)
      {
        navigateAndFinish(context,Login());
      }
    });
  }
  Widget builtBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height:50,
          ),
          Text(
            model.title,
            style:const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Colors.purple,fontFamily: 'Jannah'),
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Jannah',
              color: Colors.grey
            ),
          ),
          Expanded(
            child: Image(
              image: AssetImage(model.image),
              width: 300,
              fit: BoxFit.contain,
              //height: 4,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
}
