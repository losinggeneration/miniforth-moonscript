export stack

class stack
	new: =>
		@n = 0
		@s = {}

	peek: =>
		@s[@n]

	push: (...) =>
		for n = 1, #arg do
			@n += 1
			@s[@n] = arg[n]

	pop: (n = 1) =>
		x = {}
		while n > 0 do
			if @n > 0
				table.insert x, @s[@n]
				@s[@n] = nil
				@n -= 1
				x
			n -= 1

		unpack x
