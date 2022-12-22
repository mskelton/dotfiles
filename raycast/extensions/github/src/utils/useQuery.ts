import { getPreferenceValues, showToast, Toast } from "@raycast/api"
import { useFetch } from "@raycast/utils"

type Variables = Record<string, unknown>

interface GraphQLResponse<T> {
  data: T
  errors?: {
    message: string
  }[]
}

interface UseQueryOptions {
  enabled?: boolean
  errorMessage: string
  query: string
  variables?: Variables
}

export function useQuery<T>({
  query,
  errorMessage,
  variables,
  enabled = true,
}: UseQueryOptions) {
  const preferences = getPreferenceValues()

  return useFetch<T>("https://api.github.com/graphql", {
    method: "POST",
    execute: enabled,
    body: JSON.stringify({ query, variables }),
    headers: {
      Authorization: `Bearer ${preferences.token}`,
    },
    keepPreviousData: true,
    async parseResponse(response) {
      const { errors, data } = (await response.json()) as GraphQLResponse<T>

      if (errors?.length) {
        throw new Error(errors[0].message)
      }

      return data
    },
    onError() {
      showToast(Toast.Style.Failure, errorMessage)
    },
  })
}
