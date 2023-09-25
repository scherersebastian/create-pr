#!/bin/bash
set -e

# Konstanten
REPO_FULL_NAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")

# Eingabevariablen aus action.yml
BASE_BRANCH="$INPUT_BASE"
HEAD_BRANCH="$INPUT_HEAD"
PR_TITLE="$INPUT_TITLE"
PR_BODY="$INPUT_BODY"

# Erstellt einen PR
PR_JSON=$(printf '{"title":"%s", "head":"%s", "base":"%s", "body":"%s"}' "$PR_TITLE" "$HEAD_BRANCH" "$BASE_BRANCH" "$PR_BODY")
PR_RESPONSE=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3+json" -d "$PR_JSON" "https://api.github.com/repos/$REPO_FULL_NAME/pulls")

# Überprüft, ob PR erfolgreich erstellt wurde
if echo "$PR_RESPONSE" | jq -e .errors > /dev/null; then
  echo "Fehler beim Erstellen des PRs:"
  echo "$PR_RESPONSE" | jq .errors
  exit 1
fi

echo "PR erfolgreich erstellt:"
echo "$PR_RESPONSE" | jq .html_url
