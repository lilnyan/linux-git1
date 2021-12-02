name: CountFiles

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

  workflow_dispatch:

jobs:
  build:
    # The type of runner 
    runs-on: ubuntu-latest
  
  steps:
      # Checks-out repository under $GITHUB_WORKSPACE
      - uses: actions/checkout@v2

      # Runs a set of commands using the runners shell
      - name: Run a multi-line script
        run: |
    # make file runnable, might not be necessary
    chmod +x "${GITHUB_WORKSPACE}/.github/script.sh"

    # run script
    "${GITHUB_WORKSPACE}/.github/script.sh"
