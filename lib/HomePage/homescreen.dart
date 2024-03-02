import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo/HomePage/clipper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.sort,size: 35,)
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search,size: 35,)
                  )
                ],
              ),
              SizedBox(height: 30,),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 230),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Week',
                        style:TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      LinearPercentIndicator(
                        width: 200,
                        barRadius:Radius.circular(10),
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 16.0,
                        percent:0.4,
                        center: Text(''),
                        progressColor: Colors.purple,
                        backgroundColor: Colors.purple.shade50,
                      ),
                      SizedBox(height: 5,),
                      Text('  16 Tasks',
                        style:TextStyle(
                            fontSize: 16,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  )
                ],
              ),
            SizedBox(height: 20,),
              Stack(
                children: [
                  ClipPath(
                    child: Container(
                      margin: EdgeInsets.only(top: 22),
                      width: 350,
                      height: 230,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:   EasyDateTimeLine(
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {
                          //`selectedDate` the new date selected.
                        },
                        activeColor: Color(0xff37306B),
                        headerProps: EasyHeaderProps(
                          monthPickerType: MonthPickerType.switcher,
                          selectedDateFormat: SelectedDateFormat.fullDateDayAsStrMY,
                        ),
                        dayProps: EasyDayProps(
                          inactiveDayNumStyle: TextStyle(
                            color: Colors.white
                          ),
                          activeDayStyle: DayStyle(
                            borderRadius: 32,
                          ),
                          todayHighlightColor: Colors.orange,
                          todayHighlightStyle: TodayHighlightStyle.withBackground,
                          inactiveDayStyle: DayStyle(
                            borderRadius: 32
                          ),
                        ),
                        timeLineProps: EasyTimeLineProps(
                          hPadding: 16,
                          separatorPadding: 16,
                        ),
                      )
                    ),
                    clipper: CClipPath(),
                  ),
                  ClipPath(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      width: 220,
                      height: 270,
                      decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                width: 35,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                child: Text('3/6',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green.shade900,

                                  ),
                                ),
                              ),
                              Text('  Tasks',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.grey.shade100,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('You marked 3/8\nTasks are done',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey.shade100,
                            ),
                          ),
                          SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white70,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ),
                              child: Text('See Tasks',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          )
                        ],
                      ),
                    ),
                    clipper: CustomClipPath(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('For Today',
                style:TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 350,
                height: 400,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)
                      ),
                      child: ListTile(
                        leading:  Container(
                          width: 60,
                          height: 60,
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/profile.png'),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios)),
                        title: Text('User Research'),
                        subtitle: Text('9:00 AM - 11:00 AM'),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
