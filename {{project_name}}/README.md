# {{ project_name }}

{{ project_description }}

## Requirements

- Python {{ python_version }}+
- [Poetry](https://python-poetry.org/)

## First-time setup

Configure Poetry to create virtualenvs inside the project folder:
```bash
poetry config virtualenvs.in-project true
```

Install dependencies:
```bash
poetry install --with dev
```

Activate the virtual environment:
```bash
poetry shell
```

Install pre-commit hooks:
```bash
poetry run pre-commit install
```

## Development

Common commands via Makefile:
```bash
make install    # install all dependencies
make lint       # run ruff linter
make format     # run ruff formatter
make typecheck  # run mypy
make test       # run pytest with coverage
make ci         # run all of the above
```

## Project structure
```
{{ project_name }}/
├── src/
│   └── {{ package_name }}/
│       └── __init__.py
├── tests/
│   ├── unit/
│   ├── integration/
│   └── conftest.py
├── pyproject.toml
├── Makefile
└── README.md
```

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## License

{{ license }}
