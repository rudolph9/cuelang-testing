package test

import (
	"github.com/kurtrudolph/cuelang-testing:testing"
)

#BarBaz: =~"^([foo]|[bar])+$"

let expectedResult = {
	test: "ok ok": pass:       true
	test: "notOk notOk": pass: true
	test: "ok notOk": pass:    false
	test: "notOk ok": pass:    false
}

testing.#T & {
	test: [_]: subject:         #BarBaz
	test: "ok ok": ok:          "foo"
	test: "notOk notOk": notOk: ""
	test: "ok notOk": ok:       ""
	test: "notOk ok": notOk:    "foo"
} & expectedResult
