import { List } from "@raycast/api"
import { PullRequest, PullRequestListItem } from "./PullRequestListItem"

export interface PullRequestListSectionProps {
  pulls: PullRequest[]
  title: string
}

export function PullRequestListSection({
  pulls,
  title,
}: PullRequestListSectionProps) {
  return (
    <List.Section title={title}>
      {pulls.map((pull) => (
        <PullRequestListItem key={pull.id} pull={pull} />
      ))}
    </List.Section>
  )
}
