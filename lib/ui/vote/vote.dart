import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/data/election/election_list.dart';
import 'package:vote_app/data/repository/election_repository.dart';
import 'package:vote_app/ui/home/home_page.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';
import 'package:vote_app/ui/widget/load.dart';

class VotePage extends StatefulWidget {
  final int index;

  const VotePage({Key key, this.index}) : super(key: key);
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  Future<ElectionList> futureElection;
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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.blue,
        child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text(
            'Back'.toUpperCase(),
            style: h2,
          ),
        ),
      ),
      body: FutureBuilder<ElectionList>(
        future: futureElection,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List.generate(
              snapshot.data.elections[widget.index].parties.parties.length,
              (index) {
                dataMap.putIfAbsent(
                  snapshot
                      .data.elections[widget.index].parties.parties[index].name,
                  () => snapshot
                      .data.elections[widget.index].score.scores[index].score
                      .toDouble(),
                );
              },
            );
            return _buildBody(snapshot);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          return Center(
            child: Center(child: Text('asd')),
          );
        },
      ),
    );
  }

  Align _buildBody(AsyncSnapshot asyncSnapshot) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'VOTE',
              style: h0,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            buildpie(
              map: dataMap,
              electionTitle:
                  asyncSnapshot.data.elections[widget.index].description,
              dateEnd: asyncSnapshot.data.elections[widget.index].dateEnd,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Select to vote'.toUpperCase(),
                style: h2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: asyncSnapshot
                    .data.elections[widget.index].parties.parties.length,
                itemBuilder: (context, e) {
                  return gfCard(
                      asyncSnapshot.data.elections[e].parties.parties[e].name
                          .toString(),
                      e);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  GFCard gfCard(String title, int index) {
    return GFCard(
      content: GestureDetector(
        onTap: () {
          onLoad(context: context, text: 'Warning', function: () {});
        },
        child: Container(
          child: Center(
            child: Text(
              title,
              style: h0,
            ),
          ),
          width: 200,
          height: 100,
          color: colorList[index],
        ),
      ),
    );
  }

  Widget buildpie({Map map, String electionTitle, String dateEnd}) {
    int totalvote;
    print(totalvote.toString());
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 300,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text(electionTitle),
              PieChart(
                colorList: colorList,
                dataMap: map,
              ),
              Expanded(
                child: Row(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
