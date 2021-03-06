package testing

T :: {
	test: Test
	test_ = test
	FAIL: (checkTests & {passValue: false, "test": test_}).result
	PASS: (checkTests & {passValue: true, "test":  test_}).result
}

NumDot :: =~"^[0-9]+([.]?[0-9])*$"

Test :: {
	subject?:                   _
	[!="assert" & !="subject"]: Test
	assert?:                    {
		ok: _
		testResult = ok & subject
		pass: testResult != _|_
	} | {
		notOk: _
		testResult = notOk & subject
		pass: testResult == _|_
	}
}

checkTests :: {
	passValue?: bool
	test:       Test
	result: {
		test_ = test
		passValue_ = passValue
		if (isFieldDefined & {struct: test_, field: "assert"}).result {
			if test_.assert.pass == passValue_ {
				assert: test_.assert
				if (isFieldDefined & {struct: test_, field: "subject"}).result {
					subject: test_.subject
				}
			}
		}
		for k, v in test_ {
			if (k != "assert" && k != "subject") {
				failedTests = (checkTests & {test: v, passValue: passValue_}).result
				if !(isStructEmpty & {struct: failedTests}).result {
					"\(k)": failedTests
				}
			}
		}
	}
}

isFieldDefined :: {
	struct: {...} // set the key we're checking
	field:        string
	result:       (struct & {[_]: _ | *_|_})[field] != _|_
}

isStructEmpty :: {
	struct: {...}
	testStruct = struct & {[_]: _|_}
	result: testStruct != _|_
}
