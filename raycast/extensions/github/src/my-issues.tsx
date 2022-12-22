import { getPreferenceValues, List } from "@raycast/api"
import { Issue } from "./components/IssueListItem"
import { IssueListSection } from "./components/IssueListSection"
import { Pager } from "./utils/types"
import { useQuery } from "./utils/useQuery"

interface QueryResponse {
  search: Pager<Issue>
}

const QUERY = `
query MyIssues($query: String!, $last: Int!) {
  search(type: ISSUE, query: $query, last: $last) {
    nodes {
      ... on Issue {
        id
        number
        title
        url
        updatedAt
        state
        comments {
          totalCount
        }
      }
    }
  }
}
`

export default function MyIssues() {
  const preferences = getPreferenceValues()
  const baseQuery = `is:issue author:@me ${preferences.query}`

  const openIssues = useQuery<QueryResponse>({
    query: QUERY,
    errorMessage: "Could not load open issues",
    variables: { last: 20, query: `${baseQuery} is:open` },
  })
  const closedIssues = useQuery<QueryResponse>({
    query: QUERY,
    errorMessage: "Could not load closed issues",
    variables: { last: 5, query: `${baseQuery} is:closed` },
  })

  return (
    <List
      isLoading={openIssues.isLoading || closedIssues.isLoading}
      searchBarPlaceholder="Filter issues by name..."
    >
      <IssueListSection
        title="Open"
        issues={openIssues.data?.search.nodes ?? []}
      />

      <IssueListSection
        title="Recently closed"
        issues={closedIssues.data?.search.nodes ?? []}
      />
    </List>
  )
}
