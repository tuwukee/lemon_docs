# Lemon Docs

TODO: Add description

## Installation

### As gem

`gem install lemon_docs`

### From source

```
git clone git@github.com:tuwukee/lemon_docs.git
cd lemon_docs
rake
```

## Usage

Convert API Blueprint files to JSON.
```
require 'lemon_docs'
LemonDocs.parse('# API doc', strict: true, show_output: true)
```
LemonDocs#parse also accepts named params 'strict' and 'show_output', enabled by default. If strict mode is disabled, warnings are ignored.

Or via rake task. Generated files will be placed under doc/lemon_pages.
```
rake lemon_docs:generate_json[path/to/folder]
```

## Contributing
Fork & Pull Request

## License
MIT License.
