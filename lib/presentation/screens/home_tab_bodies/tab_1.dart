import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../constants/sample_tier.dart';

class TabBar1 extends StatelessWidget {
  const TabBar1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: AnimationLimiter(
          child: AnimationConfiguration.staggeredList(
        position: 1,
        child: SlideAnimation(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 500),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffC9C9C9),
                ),
                padding: EdgeInsets.all(10),
                height: 153,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "${tier.tier_id.image}",
                          width: 91,
                          height: 91,
                        ),
                        Text(
                          "${tier.tier_id.name} (Current)",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "${tier.tier_id.description}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Color(0xff383A3F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.2, vertical: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your accomodations",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                    // textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      )),
    );
  }
}
