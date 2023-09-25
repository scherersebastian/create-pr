# create-pr

Example workflow:

```yaml
name: Erstellen Sie einen Pull Request und ändern Sie die SECURITY.md

on:
  push:
    branches:
      - feature-*
  workflow_dispatch:

jobs:
  update-and-create-pr:
    runs-on: ubuntu-latest

    permissions:
      actions: write
      checks: write
      contents: write
      deployments: write
      id-token: write
      issues: write
      discussions: write
      packages: write
      pages: write
      pull-requests: write
      repository-projects: write
      security-events: write
      statuses: write

    steps:
    - name: Check out code
      uses: actions/checkout@v3

    - name: Änderung in SECURITY.md
      run: |
        echo "Neue Sicherheitsinformation" >> SECURITY.md
        git config --global user.name 'GitHub Action'
        git config --global user.email 'action@github.com'
        git commit -am "Update SECURITY.md durch GitHub Action"

    - name: Push changes to the remote
      run: git push origin ${{ github.ref_name }}

    - name: Set up GitHub CLI
      run: |
        sudo apt-get update
        sudo apt-get install -y gh

    - name: Authentifizierung mit GitHub CLI
      run: gh auth login --with-token <<< "${{ secrets.GITHUB_TOKEN }}"

    - name: Create a new branch
      run: |
        git checkout -b feature/update-security-$(date +'%Y%m%d%H%M%S')

    - name: Änderung in SECURITY.md
      run: |
        echo "Neue Sicherheitsinformation" >> SECURITY.md
        git config --global user.name 'GitHub Action'
        git config --global user.email 'action@github.com'
        git commit -am "Update SECURITY.md durch GitHub Action"

    - name: Push changes to the remote
      run: git push origin HEAD

    - name: Create PR
      uses: scherersebastian/create-pr@main
      with:
        base: 'main'
        head: feature/update-security-$(date +'%Y%m%d%H%M%S')
        title: 'AutomatischerPRfürSicherheitsupdate'
      env:
        INPUT_TITLE: 'Automatischer PR für Sicherheitsupdate'
        INPUT_BODY: 'Details für diesen PR...'
```
