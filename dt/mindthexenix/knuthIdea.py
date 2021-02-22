#!/usr/bin/python
"""
Mastermind game strategy generator
by NASZVADI, Peter, 2021
"""

INDENTSTR = "       "

RESPONSES = [(b, c) for b in range(5) for c in range(5) if b + c + (c==1) < 5]

XSET = [(a, b, c, d) for a in range(1, 7) for b in range(1, 7)
        for c in range(1, 7) for d in range(1, 7)]

COLOURS = lambda x: " BWGRYU"[x]

ITVP = lambda x: "(" + ("b" * x[0] + "w" * x[1] + "....")[:4] + ")"

def delta(a, b):
    if a == b:
         return (len(a), 0)
    aa, bb = zip( * filter(lambda x: x[0] != x[1], zip(a, b)))
    c = sum(min(max(0, aa.count(i)), bb.count(i)) for i in set(aa))
    return (len(a) - len(aa), c)


"""
Determines the minimum of the maxima of subsets after
each split, returns a code
"""
def miniMax(sliceThese, tryThese):
    smallestSize, bet = len(sliceThese) + 1, None
    for guess in tryThese:
        currentMaxSize = 0
        """
        The following tweak advances prefering tips among the remaining
        possible codes, this is a penalty value
        """
        bias = [0, 0.5][guess in sliceThese]
        for hits in RESPONSES:
            currentMaxSize = max(currentMaxSize, len(tuple(filter(lambda x:
                hits == delta(guess, x), sliceThese))) - bias)
            if currentMaxSize >= smallestSize:
                break
        if currentMaxSize < smallestSize:
            smallestSize, bet = currentMaxSize, guess
    return bet

"""
Heuristic mastermind algorithm generator, minimizes
the maxima of the subsets after each split
"""
def miniMaxStrat(sliceThese, tryThese, indent = 0):
    currentDepth = 0
    if len(sliceThese) != 1:
        actual = miniMax(sliceThese, tryThese)
        print("%s[%s]" % (INDENTSTR * indent, ''.join(map(COLOURS, actual))))
        for itV in RESPONSES[:-1]:
            instance = list(filter(lambda x: delta(x, actual) == itV,
                sliceThese))
            if len(instance):
                print("%s%s" % (INDENTSTR * indent, ITVP(itV)))
                currentDepth = max(currentDepth, miniMaxStrat(instance,
                    [y for y in tryThese if y != actual], 1 + indent))
        for itV in [RESPONSES[-1]]:
            instance = list(filter(lambda x: delta(x, actual) == itV,
                sliceThese))
            if len(instance):
                print("%s%s Win in step %d" % (INDENTSTR * indent, ITVP(itV),
                    indent + 1))
    else:
        print("%s[%s]\n%s(bbbb) Win in step %d" % (INDENTSTR * indent,
            ''.join(map(COLOURS, sliceThese[0])), INDENTSTR * indent,
                indent + 1))
    return max(currentDepth, indent)

print("Colours = 6, code length = 4"
    ", max steps = %d" % (1 + miniMaxStrat(XSET, XSET)))
