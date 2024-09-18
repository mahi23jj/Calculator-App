import 'package:calculator/provider.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expration = ""; // . 0-9
  String operand = " "; // + - * /
  String result = "";



  void pressed(String a) {
    setState(() {
      if (a == 'AC') {
        expration = '';
      } else if (a == 'del') {
        if (expration.isNotEmpty) {
          expration = expration.substring(0, expration.length - 1);
        }
      } else if (a == '+/-') {
        expration =
            expration.startsWith('-') ? expration.substring(1) : '- $expration';
      } else if (a == '%') {
        expration = '${expration}/100';
      } else if (a == '.') {
        if (expration.contains('.')) {
          expration = expration;
        } else {
          expration += a;
        }
      } else if (a == '=') {
        expration = expration.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expration);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          context
              .read<calculator>()
              .addHistory(Name(Title: expration, subtitle: '$eval'));
          expration = '$eval';
        } catch (e) {
          'error';
        }
      } else {
        if (['+', '-', 'x', '/'].contains(a)) {
          if (expration.isNotEmpty &&
              ['+', '-', 'x', '/'].contains(expration[expration.length - 1])) {
            expration = expration.substring(0, expration.length - 1) +
                a; // Replace last operator
          } else {
            expration += a; // Append new operator
          }
        } else {
          expration += a; // Append number or other characters
        }

      }
    });
  }
void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
           var calc=Provider.of<calculator>(context, listen: true);
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(itemBuilder: (context, index) {
            
                    return ListTile(title: Text(calc.historyList[index].Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),subtitle:Text('= ${calc.historyList[index].subtitle}') );
                  }, itemCount: calc.historyList.length),
          );
        });
  }



  // widget of the buttons
  Widget circle({required String a}) {
    return GestureDetector(
      onTap: () {
        //   elem(a);
        //print(a);
        pressed(a);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 99, 97, 97),
              Color.fromARGB(255, 97, 97, 99)
            ],
          ),
        ),
        child: Center(child: Text(a)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   // var calc = Provider.of<calculator>(context, listen: true);
    return Scaffold(
      appBar: AppBar(actions: [TextButton(onPressed: () {
        _showModalSheet();
      }, child: Text('History',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))],),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment
                    .end, // Aligns the text at the bottom of the Row
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      child: Text(
                        expration,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 210, bottom: 0),
            child: Column(
              // verticalDirection: VerticalDirection.down,
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    circle(a: 'AC'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '+/-'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '%'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '/')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    circle(a: '7'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '8'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '9'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: 'x')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    circle(a: '4'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '5'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '6'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '-')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    circle(a: '3'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '2'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '1'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '+')
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    circle(a: '0'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '.'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: 'del'),
                    SizedBox(
                      width: 25,
                    ),
                    circle(a: '=')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
