class stack
	new: =>
		@s = {}

	peek: =>
		@s[#@s]

	push: (...) =>
		arg = {...}
		for n = 1, #arg do
			@s[#@s + 1] = arg[n]

	pop: (n = 1) =>
		x = {}
		while n > 0 do
			if #@s > 0
				table.insert x, @s[#@s]
				@s[#@s] = nil
			n -= 1
		unpack x

{ :stack }
