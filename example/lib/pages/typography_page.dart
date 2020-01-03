import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:flutter_jsx_example/layouts/fullscreen_image.dart';
import 'package:flutter_jsx_example/layouts/sidebar.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TypographyPage extends StatefulWidget {
  @override
  _TypographyPage createState() => new _TypographyPage();
}

class _TypographyPage extends State<TypographyPage> {

  bool highlight, displayInline;
  DisplayLine displayLine;

  List<String> allowedElements = [
    'p',
    'b',
    'i',
    'u',
    's',
    'a',
    'br',
    'mute',
    'q',
    'center',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'img',
    'pre',
    'code',
    'widget'
  ];

  @override
  void initState() {
    highlight = false;
    displayInline = false;
    displayLine = DisplayLine.block;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery = MediaQuery.of(context);

    Color
      hilightedColor = Colors.yellowAccent,
      hilightColor = highlight ? hilightedColor : Colors.transparent;

    TextStyle defaultStyle = TextStyle(
      inherit: true,
      color: Colors.black
    );

    ImageProvider turtleImage = AssetImage('assets/TMNT.jpg');

    return Scaffold(
        appBar: AppBar(
          title: const Text(
              'Typography', overflow: TextOverflow.ellipsis),
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
                    padding: EdgeInsets.only(bottom: 20),
                    children: <Widget>[

                      JSX(
                        '<h6>h6. Colored heading</h6>',
                        allowedElements: allowedElements,
                        margin: EdgeInsets.only(bottom: 40),
                        backgroundColor: hilightColor,
                        textStyle: TextStyle(color: Colors.blueGrey, fontStyle: FontStyle.italic),
                        display: displayLine,
                      ),

                      JSX(
                        '<h1>h1. Responsive heading</h1>'
                        '<h2>h2. Responsive heading</h2>'
                        '<h3>h3. Responsive heading</h3>'
                        '<h4>h4. Responsive heading</h4>'
                        '<h5>h5. Responsive heading</h5>'
                        '<h6>h6. Responsive heading</h6>',
                        stylesheet: {
                          'h1': JSXStylesheet( displayLine: displayLine ),
                          'h2': JSXStylesheet( displayLine: displayLine ),
                          'h3': JSXStylesheet( displayLine: displayLine ),
                          'h4': JSXStylesheet( displayLine: displayLine ),
                          'h5': JSXStylesheet( displayLine: displayLine ),
                          'h6': JSXStylesheet( displayLine: displayLine ),
                        },
                        margin: EdgeInsets.only(bottom: 20),
                        allowedElements: allowedElements,
                        backgroundColor: hilightColor,
                        display: displayLine,
                      ),

                      JSX(
                        '<center>'
                            '<RebelAliance/> Text with widget <RebelAliance/>'
                            '\n\n'
                            '<BackTo90s/>'
                            '<p>It´s pizza time!</p>'
                        '</center>',
                        stylesheet: {
                          'RebelAliance': JSXStylesheet(
                            displayLine: DisplayLine.inline,
                            margin: EdgeInsets.symmetric(horizontal: 5.0)
                          ),
                          'BackTo90s': JSXStylesheet( borderRadius: BorderRadius.all(Radius.circular(30.0)) ),
                          'p': JSXStylesheet( displayLine: displayLine ),
                        },
                        widgets: {
                          'RebelAliance': Icon(FontAwesomeIcons.rebel, color: Colors.red),
                          'BackTo90s': InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute( builder: (BuildContext context) => FullscreenImageView(turtleImage) ));
                            },
                            child: Image(
                              image: turtleImage,
                              width: mediaQuery.size.width * 0.9,
                            )
                          )
                        },
                        margin: EdgeInsets.only(bottom: 20),
                        backgroundColor: hilightColor,
                        textStyle: TextStyle(fontSize: 16, color: Colors.black),
                        renderNewLines: true,
                        display: displayLine,
                      ),

                      JSX(
                        '<h3>Fancy display heading <mute>with faded secondary text</mute></h3>',
                        margin: EdgeInsets.only(bottom: 40),
                        allowedElements: allowedElements,
                        backgroundColor: hilightColor,
                        display: displayLine,
                      ),
                      JSX(
                        """
                          <h1>Demo Page</h1>
                          <b>Note:</b>
                          <p>This is a fantastic nonexistent product that you should buy!</p>
                          <h2>Pricing</h2>
                          <p>Lorem ipsum <b>dolor</b> sit amet.</p>
                          <p>There isn't <i>really</i> a team...</p>
                          <p>You <u>cannot</u> install a nonexistent product!</p>
                          <p><code>bdi</code> and <code>bdo</code> Test.</p>
                        """,
                        stylesheet: {
                          'h1': JSXStylesheet( displayLine: displayLine, margin: EdgeInsets.only(bottom: 10) ),
                          'h2': JSXStylesheet( displayLine: displayLine, margin: EdgeInsets.symmetric(vertical: 10)  ),
                          'p': JSXStylesheet( displayLine: displayLine )
                        },
                        margin: EdgeInsets.only(bottom: 40),
                        allowedElements: allowedElements,
                        backgroundColor: hilightColor,
                        display: displayLine,
                      ),
                      JSX(
                        '<q>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim'
                            ' veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate'
                            ' velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit '
                            'anim id est laborum.</q><p align="right"><i>Happy Tests</i> - 08 Dez 2019</p>',
                        boxDecoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 10.0, color: Colors.grey.shade600),
                          ),
                          color: hilightColor,
                        ),
                        margin: EdgeInsets.only(left: 30, right: 10),
                        allowedElements: allowedElements,
                        alignment: Alignment.topLeft,
                        display: displayLine,
                      )

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