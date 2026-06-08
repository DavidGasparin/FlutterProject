import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CardView extends StatefulWidget {
  const CardView({super.key});

  @override
  State<CardView> createState() {
    return _CardState();
  }
}

class _CardState extends State<CardView> {
  // late modifier muss ich noch machen wenn nicht gehardcodet
  Map<String, String> cardMap = {
    "Was ist die Hauptstadt von Österreich?": "Wien",
    "Was ist die Hauptstadt von Deutschland?": "Berlin",
    "Wie viele Kontinente gibt es?": "7",
    "Welcher Planet ist der Sonne am nächsten?": "Merkur",
    "Wie heißt der größte Ozean der Erde?": "Pazifischer Ozean",
    "Wer schrieb 'Faust'?": "Johann Wolfgang von Goethe",
    "Wie viele Tage hat ein Schaltjahr?": "366",
    "Was ist die chemische Formel von Wasser?": "H2O",
    "Welches Tier wird als König der Tiere bezeichnet?": "Löwe",
    "Wie viele Minuten hat eine Stunde?": "60",
    "Wer malte die Mona Lisa?": "Leonardo da Vinci",
    "Was ist die Wurzel aus 81?": "9",
    "Welches Land hat die Form eines Stiefels?": "Italien",
    "Wie heißt der höchste Berg der Welt?": "Mount Everest",
    "Wie viele Bundesländer hat Österreich?": "9",
    "Welche Programmiersprache verwendet Flutter?": "Dart",
    "Wie viele Sekunden hat eine Minute?": "60",
    "Welches Organ pumpt Blut durch den Körper?": "Herz",
    "Was ist die größte Wüste der Erde?": "Antarktische Wüste",
    "Wie heißt der rote Planet?": "Mars"
  };
  List<String> questionList = [];


  Box cards = Hive.box("Cards");

  @override
  void initState() {
    super.initState();
    cards.put('Cards',cardMap);

    loadCard();
    questionList = cardMap.keys.toList();
  }

  void loadCard() {
    setState(() {
      cardMap = Map<String, String>.from(
        cards.get("Cards") ?? {},
      );
    });
  }
  String question = "frage 1";
  String answer = "answer 1";
  bool flipped = false;
  bool wasright = false;

  void flip() {
    setState(() {
      flipped = !flipped;


    });
  }

  void getQuestions(){
    setState(() {
      question = questionList.first;
      answer = cardMap[questionList.first]!;
    });
  }

  void removeQuestion(){
    setState(() {
      questionList.remove(question);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 600,
              child: FloatingActionButton(
                onPressed: () {
                  flip();
                },
                child: Text(
                  flipped ? answer : question,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FloatingActionButton(onPressed: (){
              getQuestions();
              removeQuestion();
              
              
            },child: Text("Korrekt"),)
            
            

          ],
        ),
      ),
    );
  }
}
