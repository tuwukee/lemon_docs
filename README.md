# Lemon Docs

TODO: Add description

## Installation

`gem 'lemon_docs'`

## Usage

Compilation of C-modules
```
rake lemon_docs:compile
```

Convert API Blueprint files to JSON.
```
require 'lemon_docs'
LemonDocs.parse('# API doc')
```
Or via rake task. Generated files will be placed under doc/lemon_pages.
```
rake lemon_docs:generate_json[path/to/folder]
```

## Contributing
Fork & Pull Request

## License
MIT License.
