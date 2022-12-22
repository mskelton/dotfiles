import { List } from "@raycast/api"
import { Repository, RepositoryListItem } from "./RepositoryListItem"

export interface RepositoryListSectionProps {
  repos: Repository[]
  title: string
}

export function RepositoryListSection({
  repos,
  title,
}: RepositoryListSectionProps) {
  return (
    <List.Section title={title}>
      {repos.map((repo) => (
        <RepositoryListItem key={repo.id} repo={repo} />
      ))}
    </List.Section>
  )
}
