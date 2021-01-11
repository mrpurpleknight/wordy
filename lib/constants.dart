import 'package:flutter/material.dart';

const Color gradientBegin = Color(0xff6751b5);
const Color gradientMed = Color(0xff9354b9);
const Color gradientEnd = Color(0xFFCC95C0);
const Color backgroundColor = gradientBegin;
const Color accentColor = gradientMed;

const String randomWordUrl = 'https://random-word-api.herokuapp.com/word';

const String vocabularyWordUrl = 'https://wordsapiv1.p.rapidapi.com/words/';
const String x_rapid_key = '027991e8c4msh74c4ade18c566dbp108871jsn5a0125b5c1fb';
const String x_rapid_host = 'wordsapiv1.p.rapidapi.com';

const String suggestionWordUrl = 'https://api.datamuse.com/words?'; //sp=lis?*&max=5

const int CACHE_SIZE = 5;
const int SUGGESTIONS_NUMBER = 6;
