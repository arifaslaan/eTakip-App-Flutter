import 'package:e_takip/login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:e_takip/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TabsDemoScreen extends StatefulWidget {
  final kimlikno;
  final mycurrentTabIndex;
  TabsDemoScreen({Key key, @required this.kimlikno, this.mycurrentTabIndex}) : super(key: key);
  final String title = "Flutter Bottom Tab demo";
  @override
  _TabsDemoScreenState createState() => _TabsDemoScreenState();
}
var laststatu = [];
var allstatus = [];
var allstatusLength = 0;
var desktime;
var soapnumber;
var waternumber;
double myheight;
double mywidth;
double mywidth2;
bool _progressBarActive = true;
class _TabsDemoScreenState extends State<TabsDemoScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs= [];
  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
  
  void initState() {
    currentTabIndex = widget.mycurrentTabIndex;
    allstatus.removeRange(0, allstatus.length);
    allstatusLength = 0;
    _progressBarActive = true;
    laststatu = [];
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getDatas());
    super.initState();
  }

  _getDatas () async{
    await setState(() {
      allstatusLength = 0;
      allstatus.removeRange(0, allstatus.length);
      allstatus = []; 
    });
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/getStatusWithTcApi.php'),
    body: {'kimlikno': widget.kimlikno}).then((UriResponse) {
      setState((){
        laststatu = [];
        laststatu = json.decode(UriResponse.body);
      });    
    });
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/getStatusListWithTcApi.php'),
    body: {'kimlikno': widget.kimlikno}).then((UriResponse1) {
      setState((){
        allstatus = json.decode(UriResponse1.body);
        allstatusLength = allstatus.length;
      });    
    });
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/getDeskCalcWithTcApi.php'),
    body: {'kimlikno': widget.kimlikno}).then((UriResponse2) {
      setState((){
        desktime = json.decode(UriResponse2.body);
      });    
    });
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/getSoapCalcWithTcApi.php'),
    body: {'kimlikno': widget.kimlikno}).then((UriResponse3) {
      setState((){
        soapnumber = json.decode(UriResponse3.body);
      });    
    });
    await http.post(Uri.encodeFull('http://arifaslan.tech/projects/graduation_project/getWaterCalcWithTcApi.php'),
    body: {'kimlikno': widget.kimlikno}).then((UriResponse4) {
      setState((){
        waternumber = json.decode(UriResponse4.body);
      });    
    });
    tabs.add(TabScreen1());
    tabs.add(TabScreen2());
    tabs.add(TabScreen3());
    _progressBarActive = false;
  }
  @override
  
  Widget build(BuildContext context) {
    myheight = MediaQuery.of(context).size.height;
    mywidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            width: mywidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TabsDemoScreen(kimlikno: widget.kimlikno, mycurrentTabIndex: currentTabIndex,)),
                    );
                  },
                ),
                IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(null),
                ),
              ],
            ),
          ),
        ],
        leading: new Container(),
      ),
      body: _progressBarActive == true? circularProgress:tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            title: Text("Güncel Durum"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Geçmiş Durumlar"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            title: Text("Kullanımlar"),
          )
        ],
      ),
    );
  }
  Widget circularProgress = Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
  );
}
class TabScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            ''+laststatu[0]['name'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            ''+laststatu[0]['surname'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),
          Text(
            'Son güncel durumu:',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Text(
            ''+laststatu[0]['statu'],
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class TabScreen2 extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    mywidth2 = mywidth-mywidth*0.069;
    return Container(
      //height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: mywidth,
                height: 40,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: mywidth/3,
                          child: Text('Tarih', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: mywidth/3,
                          child: Text('-', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: mywidth/3,
                          child: Text('Durum', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: myheight-myheight*0.2575250836120401445453630272592,
                alignment: Alignment.center,
                child: asd,
              ),
            ],
          ),
        ],
      ),

    );
  }
  Widget asd = ListView.builder(
    itemCount: allstatusLength,
    itemBuilder: (context, position) {
      return Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: mywidth2/3,
                    child: Text('${allstatus[position]['created_time']}', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: mywidth2/3,
                    child: Text('-', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: mywidth2/3,
                    child: Text('${allstatus[position]['statu']}', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
/*child: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, position) {
          return Card(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Tarih', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                  Text('Durum', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                ],
              ),
            ),
          );
        },
      ),*/
class TabScreen3 extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Çocuğunuz bugün:',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  ''+waternumber.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'kez su kullandı.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  ''+soapnumber.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'kez sabun kullandı.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  ''+desktime.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'dakika sırasında oturdu.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  