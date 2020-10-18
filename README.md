# GEDCOM Parser

Script to parse [GEDCOM](https://en.wikipedia.org/wiki/GEDCOM) files into something I can use without getting another application (such as a CSV).

## Requirements

- [Ruby](./.ruby-version)
- Bundler

## Setup

1. `bundle install`
1. Download and set a sample GEDCOM file as `file.ged`.
1. Run `ruby gedcom_to_csv.rb` and see the CSV generate as `output.csv`

## Linting

`bundle exec rubocop -a **/*.rb`

## GEDCOM Samples

The [samples/](./samples/) folder contains example GEDCOM formatted (and eventually misformatted) files with which to test the parser.

## References

- [GEDCOM Standard v5.5.1](https://edge.fscdn.org/assets/img/documents/ged551-5bac5e57fe88dd37df0e153d9c515335.pdf) (pdf)

## TODO

Everything, essentially.
