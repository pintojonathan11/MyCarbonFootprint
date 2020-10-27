import 'package:flutter/material.dart';

class InfoAlertDialog extends StatelessWidget {
  final String topic;
  final int ind;

  InfoAlertDialog({Key key, this.topic, this.ind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "Learn More";
    String content;

    if (ind == 0) {
      content =
          "Did you know that 14 plastic bags are equivalent to the amount of gas required to drive one mile? Therefore, according to the EPA, 14 plastic bags is equivalent to 404 grams of carbon dioxide, which is about 28.9 grams per plastic bag.";
    } else if (ind == 1) {
      content =
          "Did you know that a 500 ml water bottle is equivalent to 82.8 grams of carbon dioxide? It is something to consider next time you are about to throw away another plastic water bottle.";
    } else if (ind == 2) {
      content =
          "Did you know that burning one gasoline of fuel is equivalent to 8,887 grams of carbon dioxide? For long rides, carpooling is an excellent way for reducing your carbon footprint, where each mile travelled reduces your carbon footprint by 404 grams of carbon dioxide.";
    } else if (ind == 3) {
      content =
          "Did you know that the average person can walk a mile in 15 to 20 minutes? Therefore, the next time you consider driving to a nearby place, walking can offer you a healthy and carbon friendly way of travelling, where you save about 27 grams of carbon for every minute walked.";
    }

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          child: Text("Great to Know!"),
          onPressed: () => {Navigator.pop(context)},
        ),
      ],
      elevation: 24.0,
    );
  }
}
