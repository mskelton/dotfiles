return {
  parse("pw-collection", [[import Collection from 'lariat'

export class ${1:MyCollection} extends Collection {
	$0
}]]),
  parse("pw-page-object", [[import Collection from 'lariat'

export class ${1:MyCollection} extends Collection {
	constructor(page: Page) {
		super(page.locator('$2'))
	}

	$0
}]]),
}
