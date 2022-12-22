import { Action, ActionPanel, Icon, Image, List } from "@raycast/api"
import { timeAgo } from "../utils/format"
import { truthy } from "../utils/truthy"

function getStateIcon(issue: Issue): Image.ImageLike {
  return issue.state === "OPEN"
    ? { source: "icons/issue-opened.png" }
    : { source: "icons/issue-closed.png" }
}

export interface Issue {
  id: string
  number: number
  title: string
  url: string
  updatedAt: string
  state: "OPEN" | "CLOSED"
  author?: {
    avatarUrl: string
  }
  comments: {
    totalCount: number
  }
}

export interface IssueListItemProps {
  issue: Issue
}

export function IssueListItem({ issue }: IssueListItemProps) {
  return (
    <List.Item
      id={issue.id}
      title={issue.title}
      subtitle={`#${issue.number}`}
      icon={getStateIcon(issue)}
      keywords={[issue.number + ""]}
      accessories={[
        issue.comments.totalCount && {
          text: issue.comments.totalCount + "",
          icon: Icon.Bubble,
        },
        { text: timeAgo(issue.updatedAt) },
      ].filter(truthy)}
      actions={
        <ActionPanel>
          <Action.OpenInBrowser url={issue.url} />
          <Action.CopyToClipboard content={issue.url} title="Copy URL" />
        </ActionPanel>
      }
    />
  )
}
