import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';

class VotePage extends StatefulWidget {
  final Map dataMap;

  const VotePage({Key key, @required this.dataMap}) : super(key: key);
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.blue,
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back'.toUpperCase(),
            style: h2,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'VOTE',
                style: h0,
              ),
              SizedBox(
                height: 20,
              ),
              buildpie(widget.dataMap),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select to vote'.toUpperCase(),
                style: h2,
              ),
              SizedBox(
                height: 20,
              ),
              GFCarousel(
                height: 150,
                viewportFraction: 0.50,
                items: [gfCard(), gfCard(), gfCard(), gfCard()],
              )
            ],
          ),
        ),
      ),
    );
  }

  GFCard gfCard() {
    return GFCard(
      content: GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget buildpie(Map map) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Text('Title'),
              PieChart(
                dataMap: map,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Days'),
                      Text('Days'),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Days'),
                      Text('Days'),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Days'),
                      Text('Days'),
                    ],
                  ),
                  Container(
                    width: 3,
                    height: 50,
                    color: Colors.black26,
                  ),
                  Column(
                    children: [
                      Text('Days'),
                      Text('Days'),
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
