# actions-diff
Rebuild a file to the standard output and compares it to a given file. The aim
is to ensure that a given file definitions are up to date, thus were rebuilt
with the latest information.

## Usage
```
NyanKiyoshi/actions-diff <path> command ...
```

## Example
```
action "Build GraphQL Schema" {
  uses = "NyanKiyoshi/actions-diff"
  args = "graphql/schema.graphql npm run build-schema"
}
```
