return {
	parse("log", "console.log($1)$0"),
	parse("imr", "import React from 'react'"),
	parse("trans", "const [t] = useTranslation()"),
	parse("pw-describe", "test.describe('$1', () => {\n\t$3\n})\n\n$0"),
	parse("pw-test", "test('$1', async ({ ${2:page} }) => {\n\t$3\n})\n\n$0"),
	parse("pw-beforeEach", "test.beforeEach('$1', async ({ ${2:page} }) => {\n\t$3\n})\n\n$0"),
	parse("pw-beforeAll", "test.beforeEach('$1', async ($2) => {\n\t$3\n})\n\n$0"),
	parse("pw-afterAll", "test.beforeEach('$1', async ($2) => {\n\t$3\n})\n\n$0"),
}
