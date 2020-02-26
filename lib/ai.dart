import 'dart:math';
import 'card.dart';

class AI {
  static int level1Play(List<RondaCard> hand, List<RondaCard> arena) {
    List<int> handI = [];
    List<int> arenaI = [];
    hand.forEach((element) {
      handI.add(element.number);
    });
    arena.forEach((element) {
      arenaI.add(element.number);
    });
    if (handI.length < 1) {
      return -1;
    } else {
      return handI.length==1 ? 0 : Random().nextInt(handI.length - 1);
    }
  }

  static int level2Play(List<RondaCard> hand, List<RondaCard> arena) {
    List<int> handI = [];
    List<int> arenaI = [];
    int index = 0;
    hand.forEach((element) {
      handI.add(element.number);
    });
    arena.forEach((element) {
      arenaI.add(element.number);
    });
    if (handI.length < 1) {
      return -1;
    } else {
      // Logic here
      // search for the best card to earn the most of points
      // index from 0 => handI.length-1
      int points = 0;
      int p = 0;
      for (int i = 0; i < handI.length; i++) {
        if (arenaI.contains(handI[i])) {
          if((p=calculateP(arenaI, handI[i]))>points)
          {
            index = i;
            points = p;
          }
        }
      }
      return index;
    }
  }

  static int level3Play(List<RondaCard> hand, List<RondaCard> arena, int lastcardplayedbyplayer) {
    List<int> handI = [];
    List<int> arenaI = [];
    int index = 0;
    hand.forEach((element) {
      handI.add(element.number);
    });
    arena.forEach((element) {
      arenaI.add(element.number);
    });
    if (handI.length < 1) {
      return -1;
    } else if(handI.contains(lastcardplayedbyplayer)) {
      return handI.indexOf(lastcardplayedbyplayer);
    } else {
      // Logic here
      // search for the best card to earn the most of points
      // index from 0 => handI.length-1
      int points = 0;
      int p = 0;
      for (int i = 0; i < handI.length; i++) {
        if (arenaI.contains(handI[i])) {
          if((p=calculateP(arenaI, handI[i]))>points)
          {
            index = i;
            points = p;
          }
        }
      }
      return index;
    }
  }

  static int calculateP(List<int> arena, int hand) {
    int points = 0;
    if (arena.contains(hand)) {
      int h = hand + 1;
      points += 2;
      while (arena.contains(h)) {
        points++;
        h++;
      }
      return points;
    } else
      return 0;
  }
}
