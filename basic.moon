require "miniforth"
require "stack"
import extend from require "moon"

class MoonForth extends MiniForth
	new: =>
		super!
		@DS = stack!
		extend @F, {
			"DUP": -> @DS\push @DS\peek! if @DS\peek!
			"*": -> @DS\push @DS\pop! * @DS\pop!
			".": -> io.write " " .. @DS\pop!
			"": -> @mode = "stop"
		}

	interpret_number: =>
		number = tonumber @word
		if number then
			@DS\push(number)
			true

mf = MoonForth!
mf\subject [[ 5 DUP * . ]]
mf\run!
