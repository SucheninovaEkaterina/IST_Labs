(deffunction ask-value (?question)
    (print ?question)
    (bind ?answer (read))
    ?answer
    )

(deffunction ask-question (?question $?allowed-values)
    (print ?question)
    (bind ?answer (read))
    (if (lexemep ?answer) 
        then (bind ?answer (lowcase ?answer))
	    )
    (while (not (member$ ?answer ?allowed-values)) do
        (print ?question)
        (bind ?answer (read))
        (if (lexemep ?answer) 
            then (bind ?answer (lowcase ?answer))
		    )
	    )
    ?answer
    )

(deffunction yes-or-no (?question)
    (bind ?response (ask-question ?question yes no y n))
    (if (or (eq ?response yes) (eq ?response y))
        then yes 
        else no
	    )
    )
; vopros
;1
(defrule determenite-time
    (not (solution ?))
    (not (time ?))
    =>
    (assert (time (ask-value "Enter the optimal game time (min): ")))
    )

(defrule determenite-time-norm
    (not (solution ?))
    (not (time-normal ?))
    (time ?value)
    =>
    (if (< ?value 60)
        then (assert (time-normal 1))
	    )
    (if (> ?value 60)
        then (assert (time-normal 2))
	    )
)
;2
(defrule determenite-fantast-universes
    (not (solution ?))
    (not (fantast-universes ?))
    =>
    (assert (fantast-universes (yes-or-no "Is it interesting to learn about fantastic universes?: ")))
    )
;3
(defrule determenite-actor-game
    (not (solution ?))
    (not (actor-game ?))
    =>
    (assert (actor-game(yes-or-no "
Would you like to be an archaeologist, pirate, etc. in the game?: ")))
    )
;4
(defrule determenite-game-rules
    (not (solution ?))
    (not (game-rules ?))
    =>
    (assert (game-rules(yes-or-no "Likes a lot of rules?: ")))
    )
;5
(defrule determenite-puzzles
    (not (solution ?))
    (not (puzzles ?))
    =>
    (assert (puzzles (yes-or-no "Do you like puzzles?: ")))
    )

(defrule determene-fantastica
    (and 
	    (and 
		    (time-normal 1) 
			(fantast-universes yes)
			) 
	    (actor-game no)
	    )
    (not (solution ?))
    =>
    (assert (fantastica yes))
	(print "you like science fiction" crlf)
	)

(defrule determine-research
    (and 
	    (and 
		    (time-normal 1) 
			(fantast-universes no)
			) 
	    (actor-game yes)
	    )
    (not (solution ?))
    =>
    (assert (research yes))
	(print "you are interested in research" crlf)
	)

(defrule determine-hard-fantastic
    (and 
	    (and 
		    (time-normal 2) 
			(fantast-universes no)
			) 
	    (actor-game-rules yes)
            (puzzles yes)
	    )
    (not (solution ?))
    =>
    (assert (hard-fantastic yes))
	(print "You like complex fiction" crlf)
	)

(defrule determine-resh-puzzles
    (and 
	    (and 
		    (time-normal 2) 
			(fantast-universes no)
			) 
	    (actor-game-rules no)
            (puzzles yes)
	    )
    (not (solution ?))
    =>
    (assert (resh-puzzles yes))
	(print "You like to solve puzzles" crlf)
	)


(defrule determine-adventure
    (or 
	    (fantastica yes) 
		(research yes)
	    )
    (not (solution ?))
    =>
    (assert (adventure yes))
	(print "Genre of the game: adventure" crlf)
	)


(defrule determine-hardcore
    (or 
	    (hard-fantastic yes) 
		(resh-puzzles yes)
	    )
    (not (solution ?))
    =>
    (assert (hardcore yes))
	(print "Genre of the game: hardcore games" crlf)
	)



;6
(defrule determenite-investigations
    (not (solution ?))
    (not (investigations ?))
    =>
    (assert (investigations (yes-or-no "Are you interested in Sherlock Holmes-style investigations?: ")))
    )
;7
(defrule determenite-complex-tasks
    (not (solution ?))
    (not (complex-tasks ?))
    =>
    (assert (complex-tasks (yes-or-no "Do you like solving complex tasks?: ")))
    )
;8
(defrule determenite-paranormal
    (not (solution ?))
    (not (paranormal ?))
    =>
    (assert (paranormal (yes-or-no "
Is it interesting to investigate paranormal phenomena?: ")))
    )


(defrule determine-classic-investigations
    (and 
	    (and 
		    (investigations yes) 
			(complex-tasks yes)
			) 
	    (paranormal no)
	    )
    (not (solution ?))
    =>
    (assert (classic-investigations yes))
	(print "You are interested in classic investigations" crlf)
	)

(defrule determine-paranormal-history
    (and 
	    (and 
		    (investigations no) 
			(complex-tasks yes)
			) 
	    (paranormal yes)
	    )
    (not (solution ?))
    =>
    (assert (paranormal-history yes))
	(print "You are interested in games with paranormal stories research" crlf)
	)

(defrule determine-detective
    (or 
	    (classic-investigations yes) 
		(paranormal-history yes)
	    )
    (not (solution ?))
    =>
    (assert (detective yes))
	(print "Genre of the game: Detective" crlf)
	)





;9
(defrule determenite-card-game
    (not (solution ?))
    (not (card-game ?))
    =>
    (assert (card-game (yes-or-no "
Do you prefer games where the main components are cards?: ")))
    )
;10

(defrule determenite-space
    (not (solution ?))
    (not (space ?))
    =>
    (assert (space (yes-or-no "Are you interested in games that take up a lot of space?: ")))
    )

(defrule determine-golovolomki
    (or 
	    (card-game yes) 
		(space yes)
	    )
    (not (solution ?))
    =>
    (assert (golovolomki yes))
	(print "Genre of the game: puzzles" crlf)
	)


;11
(defrule determenite-spend-time
    (not (solution ?))
    (not (spend-time ?))
    =>
    (assert (spend-time (yes-or-no "Do you like to spend time usefully, even in the game?: ")))
    )
;12
(defrule determenite-analytical-prob
    (not (solution ?))
    (not (analytical-prob ?))
    =>
    (assert (analytical-prob (yes-or-no "Do you like solving analytical problems?: ")))
    )
;13
(defrule determenite-real-life
    (not (solution ?))
    (not (real-life ?))
    =>
    (assert (real-life (yes-or-no "Are you interested in tasks that are close to real life?: ")))
    )
;14
(defrule determenite-leadership
    (not (solution ?))
    (not (leadership ?))
    =>
    (assert (leadership (yes-or-no "Do you feel leadership qualities in yourself?: ")))
    )

(defrule determine-simulators
    (and 
	    (and 
		    (spend-time yes) 
			(analytical-prob yes)
			) 
	    (real-life yes)
	    )
    (not (solution ?))
    =>
    (assert (simulators yes))
	(print "You are interested in strategy simulators" crlf)
	)

(defrule determine-abstract
    (and 
	    (and 
		    (spend-time yes) 
			(analytical-prob yes)
			) 
	    (real-life no)
	    )
    (not (solution ?))
    =>
    (assert (abstract yes))
	(print "You are interested in strategy abstract" crlf)
	)

(defrule determine-var-second
    (and 
	    (and 
		    (spend-time yes) 
			(analytical-prob no)
			) 
	    (leadership yes)
	    )
    (not (solution ?))
    =>
    (assert (var-second yes))
	(print "You are interested in creating or managing your own production system, etc." crlf)
	)

(defrule determine-var-first
    (and 
	    (and 
		    (spend-time yes) 
			(analytical-prob no)
			) 
	    (leadership no)
	    )
    (not (solution ?))
    =>
    (assert (var-first yes))
	(print "You like to develop your thinking and logic" crlf)
	)

(defrule determine-strategy
    (or 
	    (simulators yes) 
		(abstract yes)
	    )
    (not (solution ?))
    =>
    (assert (strategy yes))
	(print "Genre of the game: strategy" crlf)
	)
(defrule determine-economic
    (or 
	    (var-second yes) 
		(var-first yes)
	    )
    (not (solution ?))
    =>
    (assert (economic yes))
	(print "Genre of the game: economic games" crlf)
	)


; otvet
(defrule determine-answer1
    (or 
	    (adventure yes) 
		(hardcore yes)
	    )
    (not (solution ?))
    =>
    (assert (answer1 yes))
	(print "Result: The Lord of the Rings: Travels in Middle-Earth" crlf)
	)

(defrule determine-answer2
    (or 
	    (detective yes) 
		(hardcore yes)
                  (golovolomki yes)
	    )
    (not (solution ?))
    =>
    (assert (answer2 yes))
	(print "The result: the horror of Arkham" crlf)
	)

(defrule determine-answer3
    (or 
	    (strategy yes) 
		(economic yes)
	    )
    (not (solution ?))
    =>
    (assert (answer3 yes))
	(print "Result: March of the Ants" crlf)
	)

