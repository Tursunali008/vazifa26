import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vazifa26/model/quiz_model.dart';

class QuizeGetxController extends GetxController {
  RxList<QuizeModel> quizes = <QuizeModel>[
    QuizeModel(question: "Dunyoning eng baland tog'i qaysi?", answer: "EVEREST"),
    QuizeModel(question: "O‘zbekistonning poytaxti qayer?", answer: "TASHKENT"),
    QuizeModel(question: "Yerdagi eng katta okean qaysi?", answer: "TINCH"),
  ].obs;

  RxList<String> tappedNum = <String>[].obs;
  RxInt index = 0.obs; 

  void addQuize(String question, String answer) {
    quizes.add(
      QuizeModel(question: question, answer: answer),
    );
  }

  void addTappedLetter(String letter) {
    if (tappedNum.length < quizes[index.value].answer.length) {
      tappedNum.add(letter);
      if (tappedNum.length == quizes[index.value].answer.length) {
        _checkAnswer();
      }
    }
  }

  void _checkAnswer() {
    final currentQuiz = quizes[index.value];
    final correctAnswer = currentQuiz.answer;
    final tappedAnswer = tappedNum.join();

    if (tappedAnswer == correctAnswer) {
      Get.defaultDialog(
        backgroundColor: const Color.fromARGB(213, 115, 239, 70),
        title: "Tabriklayman Javobingiz To'g'ri!",
        titleStyle: const TextStyle(color: Colors.blue),
        content: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 110,
                height: 108,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        confirm: FilledButton(
          onPressed: () {
            tappedNum.clear();
            if (index.value < quizes.length - 1) {
              index.value++;
            } else {
              Get.defaultDialog(
                title: "Quiz Finished",
                middleText: "You have completed the quiz!",
                confirm: FilledButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    child: Text("Ok"),
                  ),
                ),
              );
            }
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Text("Ok"),
          ),
        ),
      );
    } else {
      Get.defaultDialog(
        backgroundColor: const Color.fromARGB(213, 115, 239, 70),
        title: "Javobigiz noto'g'ri",
        titleStyle: const TextStyle(color: Colors.red),
        content: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 110,
                height: 108,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.not_interested_outlined,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        confirm: FilledButton(
          onPressed: () {
            tappedNum.clear();
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            child: Text("Ok"),
          ),
        ),
      );
    }
  }
}
