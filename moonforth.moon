require "miniforth"
require "stack"

class MoonForth extends MiniForth
	new: (subj = "") =>
		super subj
		@DS = stack!
		@add_words {
			"?DUP": -> @DS\push @DS\peek! if @DS\peek! ~= 0
			"2DUP": ->
				s1, s2 = @DS\pop 2
				@DS\push s2, s1, s2, s1
			"DUP": -> @DS\push @DS\peek! if @DS\peek!
			"2DROP": -> @DS\pop 2
			"DROP": -> @DS\pop!
			"ROT": ->
				f, s, t = @DS\pop 3
				@DS\push f, t, s
			"SWAP": ->
				f, s = @DS\pop! 2
				@DS\push f, s

			"+": -> @DS\push @DS\pop! + @DS\pop!
			"-": ->
				@dictionary.SWAP!
				@DS\push @DS\pop! - @DS\pop!
			"*": -> @DS\push @DS\pop! * @DS\pop!
			"/": ->
				@dictionary.SWAP!
				@DS\push @DS\pop! / @DS\pop!
			"*/": ->
				@dictionary["/"]!
				@dictionary["*"]!
			"MOD": ->
				@dictionary.SWAP!
				@DS\push math.fmod @DS\pop!, @DS\pop!
			"NEGATE": -> @DS\push -1 * @DS\pop!

			"1+": ->
				@DS\push 1
				@dictionary["+"]!
			"1-": ->
				@DS\push 1
				@dictionary["-"]!

			".": -> io.write " " .. @DS\pop!

			"ABS": -> @DS\push math.abs @DS\pop!
			"MAX": -> @DS\push math.max @DS\pop 2
			"MIN": -> @DS\push math.min @DS\pop 2

			"": -> @mode = "stop"
		}

	interpret_number: =>
		number = tonumber @word
		if number then
			@DS\push number
			true

mf = MoonForth [[ 4 1+ DUP * . ]]
mf\run!
