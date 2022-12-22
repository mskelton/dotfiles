import { List } from "@raycast/api"
import { Pager } from "../utils/types"
import { useQuery } from "../utils/useQuery"
import { PullRequest } from "./PullRequestListItem"
import { PullRequestListSection } from "./PullRequestListSection"
import { Repository } from "./RepositoryListItem"

const QUERY = `
query ListPullRequestsQuery($owner: String!, $name: String!) {
  repository(owner: $owner, name: $name) {
    pullRequests(last: 20) {
      nodes {
        id
        title
        updatedAt
        isDraft
        state
        url
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

interface QueryResponse {
  repository: {
    pullRequests: Pager<PullRequest>
  }
}

interface PullRequestsProps {
  repo: Repository
}

export function PullRequests({ repo }: PullRequestsProps) {
  const { data, isLoading } = useQuery<QueryResponse>({
    query: QUERY,
    errorMessage: "Could not load repositories",
    variables: {
      owner: repo.owner.login,
      name: repo.name,
    },
  })

  const pulls = data?.repository.pullRequests.nodes ?? []

  return (
    <List
      isLoading={isLoading}
      searchBarPlaceholder="Filter pull requests by name..."
      navigationTitle={`Search ${repo.name} pull requests`}
    >
      <PullRequestListSection
        title="Open"
        pulls={pulls.filter((pull) => pull.state === "OPEN")}
      />

      <PullRequestListSection
        title="Recently Closed"
        pulls={pulls.filter((pull) => pull.state !== "OPEN")}
      />
    </List>
  )
}
