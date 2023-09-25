#!/bin/bash
set -e

# Eingabevariablen aus action.yml
BASE_BRANCH="$INPUT_BASE"
HEAD_BRANCH="$INPUT_HEAD"
PR_TITLE="$INPUT_TITLE"
PR_BODY="$INPUT_BODY"

echo "Debug: INPUT_TITLE = $INPUT_TITLE"

# Erstellt einen PR
gh pr create --base "$BASE_BRANCH" --head "$HEAD_BRANCH" --title "$PR_TITLE" --body "$PR_BODY"
