import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  final List<String> _triviaList = [];
  int _timeRemaining = 30;
  Timer? _timer;
  bool _isLoading = true;
  int? _selectedAnswerIndex;
  bool _hasAnswered = false;
  
  // AdMob Banner Ad
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/2934735716', // Test banner ad unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }

  Future<void> _loadQuestions() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/beer_quiz.json');
      final List<dynamic> jsonData = json.decode(jsonString);

      final allQuestions =
          jsonData.map((q) => QuizQuestion.fromJson(q)).toList();

      // Randomly select 10 questions from all available questions
      final random = Random();
      final selectedQuestions = <QuizQuestion>[];

      if (allQuestions.length <= 10) {
        selectedQuestions.addAll(allQuestions);
      } else {
        final indices = List<int>.generate(allQuestions.length, (i) => i);
        indices.shuffle(random);
        for (var i = 0; i < 10; i++) {
          selectedQuestions.add(allQuestions[indices[i]]);
        }
      }

      setState(() {
        _questions = selectedQuestions;
        _isLoading = false;
      });

      if (_questions.isNotEmpty) {
        _startTimer();
      }
    } catch (e) {
      // If no questions available, show empty state
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timeRemaining = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _handleAnswer(null); // Time's up
      }
    });
  }

  void _handleAnswer(int? answerIndex) {
    if (_hasAnswered) return;

    setState(() {
      _hasAnswered = true;
      _selectedAnswerIndex = answerIndex;
    });

    _timer?.cancel();

    final currentQuestion = _questions[_currentQuestionIndex];
    final isCorrect = answerIndex == currentQuestion.correctAnswerIndex;

    // Add haptic feedback
    if (isCorrect) {
      _correctAnswers++;
      HapticFeedback.lightImpact(); // Light vibration for correct answer
    } else {
      HapticFeedback.vibrate(); // Stronger vibration for incorrect answer
    }

    _triviaList.add(currentQuestion.trivia);

    // Wait a bit to show the result, then move to next question
    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _hasAnswered = false;
          _selectedAnswerIndex = null;
        });
        _startTimer();
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    _timer?.cancel();
    final result = QuizResult(
      totalQuestions: _questions.length,
      correctAnswers: _correctAnswers,
      triviaList: _triviaList,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('クイズ'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('クイズ'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_outline,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              Text(
                'クイズがまだ準備されていません',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ホームに戻る'),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('問題 ${_currentQuestionIndex + 1}/${_questions.length}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surfaceContainerLow,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Timer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _timeRemaining <= 5 ? Colors.red : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        color: _timeRemaining <= 5 ? Colors.white : Colors.grey[700],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$_timeRemaining秒',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _timeRemaining <= 5 ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Difficulty badge
                _buildDifficultyBadge(currentQuestion.difficulty),
                const SizedBox(height: 24),
                // Question
                Expanded(
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          currentQuestion.question,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Answer choices
                ...List.generate(
                  currentQuestion.choices.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildChoiceButton(
                      currentQuestion.choices[index],
                      index,
                      currentQuestion.correctAnswerIndex,
                    ),
                  ),
                ),
                // Banner Ad at the bottom
                if (_isBannerAdLoaded && _bannerAd != null)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceButton(String choice, int index, int correctIndex) {
    Color? buttonColor;
    IconData? icon;

    if (_hasAnswered) {
      if (index == correctIndex) {
        buttonColor = Colors.green;
        icon = Icons.check_circle;
      } else if (index == _selectedAnswerIndex) {
        buttonColor = Colors.red;
        icon = Icons.cancel;
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _hasAnswered ? null : () => _handleAnswer(index),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                choice,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(String difficulty) {
    Color badgeColor;
    IconData icon;

    switch (difficulty) {
      case 'Easy':
        badgeColor = Colors.green;
        icon = Icons.star_outline;
        break;
      case 'Medium':
        badgeColor = Colors.orange;
        icon = Icons.star_half;
        break;
      case 'Hard':
        badgeColor = Colors.red;
        icon = Icons.star;
        break;
      default:
        badgeColor = Colors.grey;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            difficulty,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
