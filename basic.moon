require "miniforth"
moon = require "moon"

class stack
	new: =>
		@n = 0
		@s = {}

	peek: =>
		@s[@n]

	push: (x) =>
		@n += 1
		@s[@n] = x

	pop: =>
		if @n > 0
			x = @s[@n]
			@s[@n] = nil
			@n -= 1
			x


class MoonForth extends MiniForth
	new: =>
		super!
		@DS = stack!
		moon.extend @F, {
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
