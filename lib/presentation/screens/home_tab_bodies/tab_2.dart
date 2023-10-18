import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../constants/sample_tier.dart';

class TabBar2 extends StatelessWidget {
  const TabBar2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: teirData.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: Duration(seconds: 2),
            child: SlideAnimation(
              // One for whole List
              duration: Duration(seconds: 1),
              child: SlideAnimation(
                // Other for particular items
                delay: Duration(seconds: 1),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 170,
                    child: Card(
                      elevation: 0,
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Image.network(
                            teirData[index].image,
                            width: 95,
                            height: 95,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            teirData[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                          Text(
                            teirData[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff9DA8C3),
                                fontSize: 11),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
