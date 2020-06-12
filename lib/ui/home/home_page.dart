import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:getflutter/getflutter.dart';
import 'package:vote_app/data/election/election_list.dart';
import 'package:vote_app/data/repository/election_repository.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/vote/vote.dart';
import '../style/text/style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<ElectionList> futureElection;
  List<Map> dataList = List();
  HashMap<String, double> hashMap = HashMap();
  Map<String, double> dataMap = Map();

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  void initState() {
    futureElection = getElectionInformation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return FutureBuilder<ElectionList>(
      future: futureElection,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data.elections.length; i++) {
            for (int j = 0;
                j < snapshot.data.elections[i].parties.parties.length;
                j++) {
              Map<String, double> data$i = {
                snapshot.data.elections[i].parties.parties[j].name:
                    snapshot.data.elections[i].score.scores[j].score.toDouble()
              };

              // hashMap.putIfAbsent(
              //   snapshot.data.elections[i].parties.parties[j].name,
              //   () =>
              //       snapshot.data.elections[i].score.scores[j].score.toDouble(),
              // );
            }
            dataList.add(data1);
          }
          print(dataList);
          return _buildBody(context, snapshot);
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildBody(BuildContext context, AsyncSnapshot snapshot) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 2)],
          color: Colors.blue,
        ),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            'Logout'.toUpperCase(),
            style: h2,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'today'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: h0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: GFCarousel(
                        viewportFraction: 0.85,
                        enableInfiniteScroll: false,
                        height: 270,
                        items: [
                          buildpie(
                              map: dataList[0],
                              dateEnd: snapshot.data.elections[0].dateEnd,
                              electionTitle:
                                  snapshot.data.elections[0].description,
                              snapshot: snapshot,
                              index: 0)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, e) {
                    return buildParties(
                        partyName:
                            snapshot.data.elections[e].parties.parties[e].name,
                        ideology: snapshot
                            .data.elections[e].parties.parties[e].ideology,
                        color: colorList[e]);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: snapshot.data.elections.length,
                  itemBuilder: (context, index) {
                    var dateEnd =
                        snapshot.data.elections[index].dateEnd.toString();
                    DateTime dateTime = DateTime.parse(dateEnd);
                    if (dateTime.isAfter(DateTime.now())) {
                      return gfCard(
                          electionTitle:
                              snapshot.data.elections[index].description,
                          dataMap: dataList[index],
                          dateEnd: snapshot.data.elections[index].dateEnd,
                          dateStart: snapshot.data.elections[index].dateStart,
                          index: index);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildParties({String partyName, String ideology, Color color}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 360,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GFAvatar(
              backgroundColor: color,
              child: Text(partyName[0].toUpperCase()),
            ),
            Text(
              partyName.toUpperCase(),
              style: h1bold,
            ),
            Text(
              ideology.toUpperCase(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget gfCard(
      {String electionTitle,
      Map dataMap,
      String dateEnd,
      String dateStart,
      int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 360,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              electionTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            PieChart(
              dataMap: dataMap,
              colorList: colorList,
            ),
            ButtonTheme(
              minWidth: double.infinity,
              child: FlatButton(
                color: Colors.blue,
                child: Text('JOIN', style: h2),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VotePage(
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildpie(
      {Map map,
      String electionTitle,
      String dateEnd,
      AsyncSnapshot snapshot,
      int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VotePage(
                index: index,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                electionTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              PieChart(
                dataMap: dataList[index],
                colorList: colorList,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Last Day'),
                      Text(dateEnd.substring(0, 10)),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Vote'),
                      // Text((map['ldp'] + map['rdp']).toInt().toString()),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Status'),
                      Text('-'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
