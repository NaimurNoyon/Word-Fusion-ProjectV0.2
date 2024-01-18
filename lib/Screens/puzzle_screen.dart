import 'package:flutter/material.dart';

class AlphabetDragAndDrop extends StatefulWidget {
  final int coinAmount;

  const AlphabetDragAndDrop({super.key, required this.coinAmount});

  @override
  _AlphabetDragAndDropState createState() => _AlphabetDragAndDropState();
}

class _AlphabetDragAndDropState extends State<AlphabetDragAndDrop> {
  late List<String> wordList;
  late List<String> word; // Declare word variable here
  List<String?> containerValues = [];
  String generatedWord = "";
  int firstEmptyIndex = 0; // Track the index of the first empty container
  int currentWordIndex = 0; // Track the current word index
  int life = 5;
  int score = 0;

  @override
  void initState() {
    super.initState();
    resetWordList();
  }

  void resetWordList() {
    setState(() {
      wordList = ["inner", "flutter", "dart"]; // Add your list of words here
      wordList.shuffle(); // Shuffle the list for random order
      currentWordIndex = 0;
      resetWord();
    });
  }

  void resetWord() {
    setState(() {
      String currentWord = wordList[currentWordIndex];
      word = currentWord.split('');
      containerValues = List.generate(8, (index) => null);
      generatedWord = "";
      firstEmptyIndex = 0;
    });
  }

  void nextWord() {
    if (currentWordIndex < 12 - 1) {
      currentWordIndex++;
      resetWord();
    }
  }

  void checkWord() {
    if (currentWordIndex < 12 - 1) {
      currentWordIndex++;
      resetWord();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLastWord = currentWordIndex == wordList.length - 1;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          //titleSpacing: -8,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Word Puzzle',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score : $score',
                    style: TextStyle(fontSize: 16),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 90,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.favorite,
                                size: 16,
                                color: Colors.grey,
                              );
                            }),
                      ),
                      SizedBox(
                        height: 30,
                        width: 90,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: life,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.favorite,
                                size: 16,
                                color: Colors.red,
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: word.map((char) {
                  return Expanded(
                    child: Draggable<String>(
                      data: char,
                      feedback: Material(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          //margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            char,
                            style: TextStyle(fontSize: 24, color: Colors.red),
                          ),
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // Highlight the first empty container
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.yellow)),
                        child: Text(
                          char,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(word.length, (index) {
                  return Expanded(
                    child: DragTarget<String>(
                      builder: (BuildContext context, List<String?> incoming,
                          List rejected) {
                        // Determine if this is the first empty container and style it differently
                        final isFirstEmpty = index == firstEmptyIndex;
                        return Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: isFirstEmpty ? Colors.green : Colors.white,
                              // Highlight the first empty container
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.yellow)),
                          child: Text(
                            containerValues[index] ?? '',
                            style: const TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          containerValues[index] = data;
                          generatedWord = containerValues
                              .where((value) => value != null)
                              .join();
                          if (containerValues
                              .indexWhere((value) => value == null) !=
                              -1) {
                            // Update the index of the first empty container
                            firstEmptyIndex = containerValues
                                .indexWhere((value) => value == null);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if ("${wordList[currentWordIndex]}" == "$generatedWord") {
                  nextWord();
                } else {
                  resetWord();
                }
              }, // Go to the next word
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text("Check Word"),
            ),
            Text(
              "Original Word: ${wordList[currentWordIndex]}",
              style: TextStyle(fontSize: 18),
            ),
            Text("Generated Word: $generatedWord",
                style: TextStyle(fontSize: 18)),
            Text("Current Word: ${currentWordIndex + 1} / ${wordList.length}",
                style: TextStyle(fontSize: 18)),
          ],
        ));
  }
}