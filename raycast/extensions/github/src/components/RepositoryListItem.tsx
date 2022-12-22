import { Action, ActionPanel, Color, Icon, Image, List } from "@raycast/api"
import { timeAgo } from "../utils/format"
import { PullRequests } from "./PullRequests"

export interface Repository {
  id: string
  url: string
  name: string
  owner: {
    login: string
  }
  openGraphImageUrl: string
  updatedAt: string
  viewerHasStarred: boolean
  stargazerCount: number
}

export interface RepositoryListItemProps {
  repo: Repository
}

export function RepositoryListItem({ repo }: RepositoryListItemProps) {
  return (
    <List.Item
      id={repo.id}
      title={repo.name}
      subtitle={repo.owner.login}
      icon={{ source: repo.openGraphImageUrl, mask: Image.Mask.Circle }}
      accessories={[
        {
          text: repo.stargazerCount + "",
          icon: {
            source: Icon.Star,
            tintColor: repo.viewerHasStarred ? Color.Yellow : undefined,
          },
        },
        { text: timeAgo(repo.updatedAt) },
      ]}
      keywords={[repo.owner.login]}
      actions={
        <ActionPanel>
          <Action.OpenInBrowser url={repo.url} />
          <Action.CopyToClipboard content={repo.url} title="Copy URL" />
          <Action.Push
            target={<PullRequests repo={repo} />}
            shortcut={{ modifiers: ["cmd"], key: "." }}
            icon={Icon.List}
            title="View Pull Requests"
          />
        </ActionPanel>
      }
    />
  )
}
