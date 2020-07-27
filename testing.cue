package testing

#T: {
	#Test: {
		[_ & !="ok" & !="notOk" & !="pass" & !="subject"]: #Test
	} | {
		subject?: _
		ok?:      _
		pass:     (*(ok & subject) | _|_) != _|_
	} | {
		subject?: _
		notOk?:   _
		pass:     (*(notOk & subject) | _|_) == _|_
	}
	test: #Test
}
