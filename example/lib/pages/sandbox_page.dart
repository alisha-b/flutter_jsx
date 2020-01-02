import 'package:flutter/material.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:flutter_jsx_example/layouts/sidebar.dart';
import 'package:flutter_responsive/flutter_responsive.dart';

class SandboxPage extends StatefulWidget {
  @override
  _SandboxPage createState() => new _SandboxPage();
}

class _SandboxPage extends State<SandboxPage> {

  bool highlight, displayInline;
  DisplayLine displayLine;

  @override
  void initState() {
    highlight = false;
    displayInline = false;
    displayLine = DisplayLine.block;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color
      hilightedColor = Colors.yellowAccent,
      hilightColor = highlight ? hilightedColor : Colors.transparent;

    TextStyle defaultStyle = TextStyle(
      inherit: true,
      color: Colors.black
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text(
              'SandBox', overflow: TextOverflow.ellipsis),
        ),
        drawer: Sidebar(),
        body: DefaultTextStyle(
          style: defaultStyle,
          child: ListView(
            children: <Widget>[
              ResponsiveContainer(
                padding: EdgeInsets.all(10),
                children: <Widget>[

                  /* ***************************************************
                  Options
                  */
                  ResponsiveRow(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      children: <Widget>[
                        SwitchListTile(
                            title: Text('Hilight text boxes'),
                            value: highlight,
                            activeColor: hilightedColor,
                            onChanged: (selected){
                              setState(() {
                                highlight = selected;
                              });
                            }
                        ),
                        SwitchListTile(
                            title: Text('Textbox displays inline'),
                            value: displayInline,
                            activeColor: hilightedColor,
                            onChanged: (selected){
                              setState(() {
                                displayInline = selected;
                                displayLine = selected ? DisplayLine.inline : DisplayLine.block;
                              });
                            }
                        ),
                      ]
                  ),

                  /* ***************************************************
                  Divider
                  */
                  ResponsiveRow(
                    margin: EdgeInsets.only(bottom: 40),
                    children: <Widget>[
                      Divider(height: 5, color: Color.fromARGB(255, 86, 61, 124))
                    ],
                  ),

                  /* ***************************************************
                  Examples
                  */
                  ResponsiveRow(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(bottom: 20),
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: double.infinity,
                        color: hilightColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(text: 'test1')
                                  ]
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(text: 'test2')
                                  ]
                              ),
                            )
                          ]
                        ),
                      ),

                      JSX(
                        'R\$ <b>99</b>,00',
                        stylesheet: {
                          'b': JSXStylesheet(
                              margin: EdgeInsets.only(left: 10),
                              textAlign: TextAlign.right,
                              textStyle: TextStyle( fontSize: 30, color: Colors.white, backgroundColor: Colors.blue )
                          )
                        },
                        margin: EdgeInsets.all(10.0),
                        backgroundColor: hilightColor,
                        display: displayLine,
                      ),

                      JSX(
                        'R\$ <b>99</b>,00',
                        stylesheet: {
                          'b': JSXStylesheet(
                              margin: EdgeInsets.only(left: 10),
                              textAlign: TextAlign.right,
                              textStyle: TextStyle( fontSize: 30, color: Colors.white, backgroundColor: Colors.blue )
                          )
                        },
                        margin: EdgeInsets.all(10.0),
                        backgroundColor: hilightColor,
                        display: displayLine,
                      ),

                    ],
                  ),

                ],
              )
            ],
          ),
        )
    );
  }
}