# actions-diff
Rebuild a file to the standard output and compares it to a given file. The aim
is to ensure that a given file definitions are up to date, thus were rebuilt
with the latest information.

## Usage
```
NyanKiyoshi/actions-diff <path> command ...
```

## Examples
```
action "Build GraphQL Schema" {
  uses = "NyanKiyoshi/actions-diff"
  args = "graphql/schema.graphql npm run build-schema"
}
```

To run a command without diff inside the container, do:
```
action "Build GraphQL Schema" {
  uses = "NyanKiyoshi/actions-diff"
  args = "- rm -rf /"
}
```

## Development
### Running Tests
Just run [`./tests/run_tests.sh`](tests/run_tests.sh), note that 
it will install dependencies.

### Testing Actions Locally
You can use [`act`](https://github.com/nektos/act) 
to test your changes locally.
