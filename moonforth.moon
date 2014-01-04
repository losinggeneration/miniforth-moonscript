require "miniforth"
require "stack"

class MoonForth extends MiniForth
	new: (subj = "") =>
		super subj
		@DS = stack!
		@add_words {
			"?DUP": -> @DS\push @DS\peek! if @DS\peek! ~= 0
			"2DUP": ->
				s1, s2 = @DS\pop!, @DS\pop!
				@DS\push s2
				@DS\push s1
				@DS\push s2
				@DS\push s1
			"DUP": -> @DS\push @DS\peek! if @DS\peek!
			"2DROP": ->
				@DS\pop!
				@DS\pop!
			"DROP": -> @DS\pop!
			"ROT": ->
				f, s, t = @DS\pop!, @DS\pop!, @DS\pop!
				@DS\push f
				@DS\push t
				@DS\push s
			"SWAP": ->
				f, s = @DS\pop!, @DS\pop!
				@DS\push f
				@DS\push s


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
			"MAX": -> @DS\push math.max @DS\pop!, @DS\pop!
			"MIN": -> @DS\push math.min @DS\pop!, @DS\pop!

			"": -> @mode = "stop"
		}

	interpret_number: =>
		number = tonumber @word
		if number then
			@DS\push number
			true

mf = MoonForth [[ 4 1+ DUP * . ]]
mf\run!
