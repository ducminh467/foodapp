import 'package:flutter/material.dart';
import 'package:foodapp/constant/constant.dart';
import 'package:foodapp/models/welcome_model.dart';

import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
@override
void initState() {
  super.initState();
  _pageController = PageController();
}
  int currentIndex = 0;

  final List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
        "lib/assets/designf.jpg",
        "Chào mừng bạn đã đến với thiên đường đồ ăn của chúng tôi",
        "Chào mừng!"),
    AllinOnboardModel(
        "lib/assets/designs.jpg",
        "Bạn có thể trải nghiệm cảm giác đươc giao đồ ăn tận giường thật nhanh chóng và tiết kiệm",
        "Giao hàng tận nhà"),
    AllinOnboardModel(
        "lib/assets/designt.jpg",
        "Chúng tôi luôn mong muốn mang đến những món ăn ngon cho cuộc sống của bạn",
        "Hãy tận hưởng cùng nhau"),
  ];
  void _nextImage() {

    setState(() {
      currentIndex = (currentIndex + 1) % allinonboardlist.length;
      _pageController.animateToPage((_pageController.page?.toInt() ?? 0) + 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

    });
  }
  void _previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1) % allinonboardlist.length;
      _pageController.animateToPage((_pageController.page?.toInt() ?? 0) - 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Food App",
          style: TextStyle(color: primarygreen),
        ),
        backgroundColor: lightgreenshede1,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: allinonboardlist.length,
              itemBuilder: (context, index) {
                return PageBuilderWidget(
                    title: allinonboardlist[index].titlestr,
                    description: allinonboardlist[index].description,
                    imgurl: allinonboardlist[index].imgStr);
              }),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allinonboardlist.length,
                    (index) => buildDot(index: index),
              ),
            ),
          ),
          currentIndex < allinonboardlist.length - 1
              ? Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousImage,
            // (
//                       ) {
//
// setState(() {
//   if (currentIndex > allinonboardlist.length - 1) {
//     currentIndex--;
//
//   } else {
//     currentIndex = 0;
//   }
// });
//                   },
                  child: Text(
                    "Trước",
                    style: TextStyle(fontSize: 18, color: primarygreen),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: lightgreenshede1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0))),
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextImage,
                  //     (
                  //     ) {
                  //
                  //   setState(() {
                  //     if (currentIndex < allinonboardlist.length - 1) {
                  //       currentIndex++;
                  //     } else {
                  //       currentIndex = 0;
                  //     }
                  //   });
                  // },
                  child: Text(
                    "Sau",
                    style: TextStyle(fontSize: 18, color: primarygreen),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: lightgreenshede1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0))),
                  ),
                )
              ],
            ),
          )
              : Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.33,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginPage()));
              },
              child: Text(
                "Bắt đầu",
                style: TextStyle(fontSize: 18, color: primarygreen),
              ),
              style: ElevatedButton.styleFrom(
                primary: lightgreenshede1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? primarygreen : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageBuilderWidget extends StatelessWidget {
  String title;
  String description;
  String imgurl;
  PageBuilderWidget(
      {Key? key,
        required this.title,
        required this.description,
        required this.imgurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(imgurl),
          ),
          const SizedBox(
            height: 20,
          ),
          //Tite Text
          Text(title,
              style: TextStyle(
                  color: primarygreen,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 20,
          ),
          //discription
          Text(description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: primarygreen,
                fontSize: 14,
              ))
        ],
      ),
    );
  }
}