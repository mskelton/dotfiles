import { List } from "@raycast/api"
import { Issue, IssueListItem } from "./IssueListItem"

export interface IssueListSectionProps {
  issues: Issue[]
  title: string
}

export function IssueListSection({ issues, title }: IssueListSectionProps) {
  return (
    <List.Section title={title}>
      {issues.map((issue) => (
        <IssueListItem key={issue.id} issue={issue} />
      ))}
    </List.Section>
  )
}
