
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Models/QuestionModel.dart';

class SearchingProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isSearching = false;
  List<QuestionModel> _searchQuestionList = [];

  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  List<QuestionModel> get searchQuestionList => _searchQuestionList;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void searchQuestions(String query, List<QuestionModel> allQuestions) {
    print("total question is:-"+allQuestions.length.toString());
    _isSearching = query.isNotEmpty;
    _searchQuestionList = allQuestions
        .where((question) => question.Question.toLowerCase()
        .contains(query.toLowerCase()))
        .toList();
    print("total question after :-"+_searchQuestionList.length.toString());


    notifyListeners(); // UI will rebuild automatically
  }
}
