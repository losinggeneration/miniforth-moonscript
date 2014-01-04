export stack

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
