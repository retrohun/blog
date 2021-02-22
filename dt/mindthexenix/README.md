# Mind the Xenix!

Some rights reserved! Vintage technology preserved.

---

[Previous](../morebootromfun) | [Index](../../../../) | [Next]
--- | --- | ---

---

Actually it would be better referring specially to xenix286 due
that regularly use to play mastermind (/usr/games/mind) delivered
with the xenix286 game package. For newbies, a standalone xenix286
virtual machine can be installed automatically without any user
interaction, see earlier writings on this here:

- [Xenix tales](../xenixtales)
- and [Xenix286 on demand](../xenix286ondemand)

This mastermind implementation can be customized, player
can change the number of colours 1 thru 9, code length
from 2 to 5, and also the application can make a code or
breaks code that is entered by the user, supposedly using
rather weak heuristics.

## Winning ways

Ripped the title from the famous book written by John Conway et
al, since my childhood I always wanted to know what is the optimal
strategy for the so-called game mastermind. It is a peg guess
with 6 colours and 4 length code, both colour reuse and illegal
guesses are allowed. Even Donald E. Knuth published a paper
containing a heuristic approach decades ago that yields a strategy
that guesses all codes in at most 5 tries - which exactly means
that the 5th or earlier try is the code itself.
Of course this could be suboptimal in general case but with this
specific constraints - 6 colours, 4 length code - yields an
optimal recipe. The heuristic itself minimizes the maximal number
of elements in each subset per response classification in the
remaining allowed codes.

## TL;DR poke time!

Here you are a vintage cheat in 2021: a cheat sheet for classic
mastermind ruleset. Generated a guess-response tree list here:

- [mindchea.txt](./mindchea.txt)

The classic tree format, leaves are denoted with sencence "Win
in step [n]", guesses are CAPITALS, responses are small words
padded with dots up to four characters.
The messy python(2-3) code also prints a small summary after
finishing tree generation, also determines maximal necessary
steps - fortunately 5 in our case. Less than 5 is impossible!

- [knuthIdea.py](./knuthIdea.py)

Happy browsing the cheat sheet in split terminal sessions
during mind gameplay!

### Remarks

Less relevant, but updated this blog's links section.
Have fun!

## Links

- [Mastermind on Wikipedia](https://en.wikipedia.org/wiki/Mastermind_(board_game))
- [Related articles, codes](http://slovesnov.users.sourceforge.net/index.php?bullscows)

---

[Previous](../morebootromfun) | [Index](../../../../) | [Next]
--- | --- | ---
