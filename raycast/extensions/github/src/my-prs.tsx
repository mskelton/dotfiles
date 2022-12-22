import { getPreferenceValues, List } from "@raycast/api"
import { PullRequest } from "./components/PullRequestListItem"
import { PullRequestListSection } from "./components/PullRequestListSection"
import { Pager } from "./utils/types"
import { useQuery } from "./utils/useQuery"

interface QueryResponse {
  search: Pager<PullRequest>
}

const QUERY = `
query MyPullRequests($query: String!, $last: Int!) {
  search(type: ISSUE, query: $query, last: $last) {
    nodes {
      ... on PullRequest {
        id
        title
        url
        updatedAt
        state
        isDraft
        repository {
          nameWithOwner
        }
        comments {
          totalCount
        }
        commits(last: 1) {
          nodes {
            commit {
              status {
                state
              }
            }
          }
        }
      }
    }
  }
}
`

export default function MyPullRequests() {
  const preferences = getPreferenceValues()
  const baseQuery = `is:pr author:@me ${preferences.query}`

  const openPRs = useQuery<QueryResponse>({
    query: QUERY,
    errorMessage: "Could not load open pull requests",
    variables: { last: 20, query: `${baseQuery} is:open` },
  })
  const closedPRs = useQuery<QueryResponse>({
    query: QUERY,
    errorMessage: "Could not load closed pull requests",
    variables: { last: 5, query: `${baseQuery} is:closed` },
  })

  return (
    <List
      isLoading={openPRs.isLoading || closedPRs.isLoading}
      searchBarPlaceholder="Filter pull requests by name..."
    >
      <PullRequestListSection
        title="Open"
        pulls={openPRs.data?.search.nodes ?? []}
      />

      <PullRequestListSection
        title="Recently closed"
        pulls={closedPRs.data?.search.nodes ?? []}
      />
    </List>
  )
}
