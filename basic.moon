require "miniforth"
require "stack"

class MoonForth extends MiniForth
	new: (subj = "") =>
		super subj
		@DS = stack!
		@add_words {
			"DUP": -> @DS\push @DS\peek! if @DS\peek!
			"*": -> @DS\push @DS\pop! * @DS\pop!
			".": -> io.write " " .. @DS\pop!
			"": -> @mode = "stop"
		}

	interpret_number: =>
		number = tonumber @word
		if number then
			@DS\push number
			true

mf = MoonForth [[ 5 DUP * . ]]
mf\run!
