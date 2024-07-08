import 'package:flutter/material.dart';

class HealthChart extends StatefulWidget {
  const HealthChart({super.key});

  @override
  State<HealthChart> createState() => _HealthChartState();
}

class _HealthChartState extends State<HealthChart> {
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [

              Text(
                "Your Weakly Timeline",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text("Your Weakly Timeline"),
              SizedBox(
                height: 140,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children:[ GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.all(8),
                              duration: Duration(microseconds: 300),
                              width: 70,
                              height: 100,
                              child: Center(
                                child: Text(
                                  days[index],style: TextStyle(color: current==index?Colors.white:Colors.black),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: current == index
                                      ? Colors.blue
                                      : Color.fromARGB(255, 232, 232, 232),
                                  borderRadius: current == index
                                      ? BorderRadius.circular(15)
                                      : BorderRadius.circular(10),
                                  border: current == index
                                      ? Border.all(color: Colors.blue, width: 2)
                                      : Border.all(color: Colors.white),
                              ),
                            )),
                          Visibility(
                            visible: current==index,
                            child: Container(
                            width:5,
                            height:5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,color: Colors.blue
                            ),

                          ),
                        )
                        ]
                      );
                    }),
              ),
             Container(margin: EdgeInsets.only(top: 30),
             width: double.infinity,
             height: 500,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   

                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}

