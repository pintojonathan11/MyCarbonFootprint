import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/info_bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Information(),
      ),
    );
  }
}

class Information extends StatelessWidget {
  Information({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
      child: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: AutoSizeText(
              "Welcome To",
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: AutoSizeText(
              "My Carbon Footprint",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Here at ',
                  ),
                  TextSpan(
                      text: 'My Carbon Footprint',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(
                    text:
                        ", we aim to help you as an individual realize your responsibility as a resident of Planet Earth and aid you in carrying out your part to reduce Carbon Emissions, thus reducing Global Warming and improving our quality of life",
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: AutoSizeText(
              "Why reduce our Carbon Footprint?",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.stream,
                        color: Colors.white,
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'The average carbon footprint for a person in the United States is ',
                          ),
                          TextSpan(
                              text: '16 Tons',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: ", which is amongst the ",
                          ),
                          TextSpan(
                              text: "highest in the world",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.stream,
                        color: Colors.white,
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Globally, the average carbon footprint is about ',
                          ),
                          TextSpan(
                            text: '4 tons',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.stream,
                        color: Colors.white,
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "To avoid the dreaded 2℃ rise in global temperatures, the average global carbon footprint per year "),
                          TextSpan(
                            text: 'needs to drop under 2 tons by 2050',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: AutoSizeText(
              "Why is an increase in 2℃ catastrophic?",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                new Container(
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    child: Text(
                      "An increase of 2℃ in global temperatures will cause severe effects on human civilization and animal life:",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "1)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'An increase in the sea-level of more than 70% of Earth’s coastlines by 0.66 feet, which in turn, will increase ',
                          ),
                          TextSpan(
                              text:
                                  'coastal flooding, beach erosion, salinization of water supplies',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: ", etc.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "2)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "An increase in temperature to even 1.5℃ will increase ocean temperatures, increase ocean acidity, and decrease oxygen levels, which will "),
                          TextSpan(
                            text:
                                'destroy numerous oceanic ecosystems and result in inefficient fisheries and aquaculture',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "3)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "Increase in "),
                          TextSpan(
                            text: 'heat-related illnesses ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "and horrific "),
                          TextSpan(
                            text: 'heat waves ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'in cities due to the urban heat island effect',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "4)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Vector-borne diseases ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  "will be widespread and will affect more people than malaria and dengue"),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "5)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Reduced food security ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  "throughout the world, especially in the African Sahel, the Mediterranean, Central Europe, the Amazon, and Western and Southern Africa"),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "6)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "Relatively "),
                          TextSpan(
                            text: 'severe economic damages ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  "from climate change as the GDP is approximated to lose 2.3% of its value"),
                        ],
                      ),
                    ),
                  ),
                ),
                new ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "7)",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  title: Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Increase in natural disasters such as "),
                          TextSpan(
                            text: 'violent wildfires ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "in California and "),
                          TextSpan(
                            text: 'devastating hurricanes ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "in the Caribbean"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: AutoSizeText(
              "What can you do to Save the Planet?",
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
            child: Image(image: AssetImage("assets/images/mycfoot.png")),
          ),
        ],
      ),
    ));
  }
}
