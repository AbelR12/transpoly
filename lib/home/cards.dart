import 'package:flutter/material.dart';
import 'creditCard.dart';

class CardsList extends StatefulWidget {
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  List cardList = [
    CreditCard(),
    CreditCard(),
  ];

  int _currentCard = 0;

  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentCard = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 246.0,
            child: PageView.builder(
              itemCount: cardList.length,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) => CreditCard(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < cardList.length; i++)
                  if (_currentCard == i)
                    DotIndicator(true)
                  else
                    DotIndicator(false)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DotIndicator extends StatefulWidget {
  final bool isActive;
  DotIndicator(this.isActive);
  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: widget.isActive ? Color(0xffffac30) : Color(0xFF8492A2),
        ),
      ),
    );
  }
}
