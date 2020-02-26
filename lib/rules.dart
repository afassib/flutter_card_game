import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Rules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: SingleChildScrollView(
              child: Html(
                data: """
                <div style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: 10px;">
<div class="markdown_content"><h1 id="introduction">Introduction</h1>
<p><strong>Ronda</strong> is a fishing game, it has Mediterranean origins, it is traced back
to Spain and north Africa (specially Morocco). Ronda is played with
Spanish/Italian deck : 40 cards containing 4 suits : coins, clubs, swords
and cups. each suit having 10 cards :<br/>
cards from 1 to 7 plus : 10 (Sota/Jack), 11 (Caballo/Horse) and 12 (Rey/King).</p>
</div>


<h1 id="how-to-play">How to play</h1>
<h3 id="game-startending">Game start/ending</h3>
<p>In the first deal each player is given 4 cards, and when all 8 cards are
used a new round starts with the distribution of other 8 cards from the
 deck.</p>
<p>The game ends when no cards remain in the deck.</p>
<h3 id="announces">Announces</h3>
<p>After each deal the player can announce :<br/>
=> Ronda : when he has 2 similar cards (same card number - same rank).<br/>
=> Tringla : when he obtains 3 similar cards.<br/>
=> Announces result extra points as explained in "Points" section below.
</p>
<h3 id="main-game">Main game</h3>
<p>Each player (in his turn) has 2 options:<br>
=> He can capture a card from the table by using one similar card from
his hand and keep taking cards incrementally starting from that number.<br>
=> He can put a card on the table when he can't capture any card.<br><br>
=> The player can also gain points by doing one of this acts:<br>
- Mesa : when a player takes all the cards on the table (except when
it's the final deal and the player is the last one)<br>
- Este : when a player takes the last card dropped by his opponent
  (check "Points" section below)<br>
- When in the last deal, and after the last turn. If there still are
cards on the table, the last player who captured a card takes them.
</p>
<h3 id="points">Points</h3>
<p>A player can get points when :<br/>
- He announced Ronda and the opponent didn't : 1 point<br/>
- Both players announced Ronda with equal rank : 1 point<br/>
- Both players announced Ronda and he has the bigger number : 2 points<br/>
- He announced Tringla and the opponent didn't : 5 point<br/>
- Both players announced Tringla with equal rank : 1 point<br/>
- Both players announced Tringla and he has the bigger number : 10 points<br/>
- He announced Tringla and the opponent announced Ronda : 6 points<br/>
- He makes an Este : 1 point<br/>
- When the game ends, all the cards above the 20th are counted as points<br/>
</p>
<h3 id="notes">Notes</h3>
<p>Ronda and Tringla are announced automatically and their points are calculated at the end of the deal.</p></div>
</div>
                """,
                padding: EdgeInsets.all(8.0),
              ),
            ),
          ),
    );
  }
}