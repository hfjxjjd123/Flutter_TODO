import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secare/data/stuff_model.dart';
import 'package:secare/provider/onclick_notifier.dart';
import 'package:secare/const/colors.dart';
import 'package:secare/repo/stuff_service.dart';
import 'package:secare/widgets/datetime_widget.dart';
import 'package:secare/widgets/on_button.dart';

enum _SelectedTab { calendar, home, analysis }

List<Widget> mainStuffs = [
  OnButton(stuff: '개발활동',),
  OnButton(stuff: '데일리스크럼 작성',),
  OnButton(stuff: '백준 1문제',),
];

List<Widget> stuffs = [
  OnButton(stuff: '#1',),
  OnButton(stuff: '#2',),
  OnButton(stuff: '#3',),
  OnButton(stuff: '#4',),
];



class DayScreen extends StatefulWidget {
  DayScreen({Key? key}) : super(key: key);

  List<bool> onList = [false,false,false,false,false,false,false,false,false,false,false];

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  var _selectedTab = _SelectedTab.home;
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }


  @override
  Widget build(BuildContext context) {
    OnclickNotifier onclickNotifier = context.watch<OnclickNotifier>();
    Size size = MediaQuery.of(context).size;
    Widget columnBigPadding(){
      return Container(height: size.height*0.03,);
    }
    Widget columnSmallPadding(){
      return Container(height: size.height*0.01,);
    }
    double buttonHeight = size.height*0.1;

    List<Widget> allStuffs = [
      ...mainStuffs,
      columnSmallPadding(),
      Divider(
        color: Colors.white,
        height: 1,
        thickness: 1,
        indent: size.width*0.15,
        endIndent: size.width*0.15,
      ),
      columnSmallPadding(),
      ...stuffs,
      UpdateButton(),
    ];

    print("모종의 이유로 rebuild 됨");



    return SafeArea(
      child: Scaffold(
        backgroundColor: offColor,
        body: Column(
          children: [
            LinearProgressIndicator(
              color: fadeColor,
              backgroundColor: Colors.transparent,
              value: onclickNotifier.count/(mainStuffs.length+stuffs.length),
              minHeight: 8,
            ),
            columnBigPadding(),
            DateView(),
            columnSmallPadding(),
            Divider(
              color: Colors.white,
              height: 1,
              thickness: 1,
              indent: size.width*0.2,
              endIndent: size.width*0.2,
            ),
            columnSmallPadding(),
            Expanded(
              child: FutureBuilder<List<StuffModel>>(
                future: StuffService().getAllStuffs("2022. 09. 22"),
                builder: (context, snapshot) {
                  for(int i=0;i<snapshot.data!.length;i++){
                      stuffs.add(OnButton(stuff: snapshot.data![i].todo));
                  }
                  return ListView.builder(
                    itemCount: (allStuffs.length),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          child: Container(child: allStuffs[index], color:(widget.onList[index])?onColor:offColor,),
                        onTap: (){
                            if(index == allStuffs.length-1){

                            } else if(index<mainStuffs.length || index>mainStuffs.length+2){
                              if(widget.onList[index]==true){
                                context.read<OnclickNotifier>().offclick();
                              } else{
                                context.read<OnclickNotifier>().onclick();
                              }
                              widget.onList[index] = !widget.onList[index];
                              setState((){});
                            }
                        },
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
        bottomNavigationBar: DotNavigationBar(
          items: [
            DotNavigationBarItem(icon: Icon(Icons.calendar_today_outlined,)),
            DotNavigationBarItem(icon: Icon(Icons.home_filled,)),
            DotNavigationBarItem(icon: Icon(Icons.person_pin,)),
          ],
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTap: _handleIndexChanged,
          backgroundColor: Color.fromARGB(255, 43, 52, 58),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          dotIndicatorColor: Colors.white,
        ),
      ),
    );
  }
}





