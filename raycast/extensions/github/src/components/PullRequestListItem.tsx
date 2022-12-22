import {
  Action,
  ActionPanel,
  getPreferenceValues,
  Icon,
  Image,
  List,
  showToast,
  Toast,
} from "@raycast/api"
import fetch from "node-fetch"
import { useState } from "react"
import { timeAgo } from "../utils/format"
import { truthy } from "../utils/truthy"

const MUTATION = (type: string) => `
  mutation($id: ID!) {
    ${type}(input: { pullRequestId: $id }) {
      clientMutationId
    }
  }
`

function getStateIcon(
  state: PullRequest["state"],
  isDraft: boolean
): Image.ImageLike {
  return state === "CLOSED"
    ? "icons/git-pull-request-closed.png"
    : state === "MERGED"
    ? "icons/git-merge.png"
    : isDraft
    ? "icons/git-pull-request-draft.png"
    : "icons/git-pull-request.png"
}

function getStatusIcon(pull: PullRequest): Image.ImageLike | undefined {
  const state = pull.commits.nodes[0].commit.status?.state

  return state === "PENDING"
    ? "icons/dot-fill.png"
    : state === "FAILURE"
    ? "icons/x.png"
    : "icons/check.png"
}

export interface PullRequest {
  id: string
  title: string
  url: string
  updatedAt: string
  state: "OPEN" | "CLOSED" | "MERGED"
  isDraft: boolean
  repository: {
    nameWithOwner: string
  }
  comments: {
    totalCount: number
  }
  commits: {
    nodes: {
      commit: {
        status?: {
          state: "PENDING" | "SUCCESS" | "FAILURE"
        }
      }
    }[]
  }
}

export interface PullRequestListItemProps {
  pull: PullRequest
}

export function PullRequestListItem({ pull }: PullRequestListItemProps) {
  const [isDraft, setIsDraft] = useState(pull.isDraft)

  async function mutate() {
    const type = isDraft
      ? "markPullRequestReadyForReview"
      : "convertPullRequestToDraft"

    const successMessage = isDraft
      ? "PR marked as ready"
      : "PR converted to draft"

    const failureMessage = isDraft
      ? "Failed to mark PR as ready"
      : "Failed to convert PR to draft"

    try {
      await fetch("https://api.github.com/graphql", {
        method: "POST",
        body: JSON.stringify({
          query: MUTATION(type),
          variables: { id: pull.id },
        }),
        headers: {
          Authorization: `Bearer ${getPreferenceValues().token}`,
        },
      })

      showToast(Toast.Style.Success, successMessage)
      setIsDraft(!isDraft)
    } catch (error) {
      console.error(error)
      showToast(Toast.Style.Failure, failureMessage)
    }
  }

  return (
    <List.Item
      id={pull.id}
      title={pull.title}
      subtitle={pull.repository.nameWithOwner}
      icon={getStateIcon(pull.state, isDraft)}
      accessories={[
        pull.comments.totalCount && {
          text: pull.comments.totalCount + "",
          icon: Icon.Bubble,
        },
        { text: timeAgo(pull.updatedAt) },
        { icon: getStatusIcon(pull) },
      ].filter(truthy)}
      keywords={pull.repository.nameWithOwner.split("/")}
      actions={
        <ActionPanel>
          <Action.OpenInBrowser url={pull.url} />
          <Action.CopyToClipboard content={pull.url} title="Copy URL" />

          {pull.state === "OPEN" && (
            <Action
              icon={isDraft ? Icon.Eye : Icon.EyeDisabled}
              shortcut={{ modifiers: ["cmd"], key: "." }}
              title={isDraft ? "Ready for Review" : "Mark as Draft"}
              onAction={mutate}
            />
          )}
        </ActionPanel>
      }
    />
  )
}
