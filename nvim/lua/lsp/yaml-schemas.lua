--- This table contains a list of file patterns and their associated default
--- YAML schema URLs.
return {
	["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
	["https://raw.githubusercontent.com/buildkite/pipeline-schema/main/schema.json"] = "/.buildkite/*",
}
