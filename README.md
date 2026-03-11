# python-project-template

A personal Python project boilerplate powered by [Copier](https://copier.readthedocs.io/).

Every new Python project you create starts from this template -- pre-wired with
dependency management, code quality tools, testing, CI/CD, and Git hygiene,
so you can focus on writing code rather than configuring tooling.

---

## What this template gives you

Every project generated from this template includes:

| Area | Tool | What it does |
|---|---|---|
| Dependency management | Poetry | Manages packages, virtualenvs, and lockfiles |
| Formatting | Ruff | Auto-formats code to a consistent style |
| Linting | Ruff | Catches bugs, bad patterns, unused imports |
| Type checking | Mypy | Catches type errors before runtime |
| Testing | pytest + pytest-cov | Runs tests with coverage reporting |
| Git hooks | pre-commit | Runs checks automatically on every commit |
| CI/CD | GitHub Actions | Runs lint, type check, and tests on push/PR |
| Branch strategy | three-tier | main / uat / dev enforced in CI |
| GitHub templates | PR + Issue | Standardised PR and issue descriptions |

### Optional extras (you choose per project)

| Option | What gets added |
|---|---|
| Notebooks | `notebooks/` folder, Jupyter, nbstripout hook |
| DuckDB | duckdb dependency, `data/` folder, .gitignore rules |
| Docs | MkDocs Material, `docs/` scaffold, `mkdocs.yml` |
| Docker | `Dockerfile`, `.dockerignore` |
| Dotenv | python-dotenv, `.env.example`, `.env` gitignored |

---

## Requirements

Before using this template, make sure you have the following installed:
```bash
# Copier -- the tool that renders the template
brew install copier

# Poetry -- used in every generated project
brew install poetry

# Git
git --version
```

### One-time Git configuration (if not already done)
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```

### Recommended Poetry configuration

This tells Poetry to create virtualenvs inside the project folder as `.venv/`
rather than in a central cache directory. Makes them easier to find and works
better with VS Code.
```bash
poetry config virtualenvs.in-project true
```

Run this once on your machine -- it applies to all future projects.

---

## How to use this template

### Step 1 -- Navigate to your projects folder

Before generating a new project, navigate to the folder where you store your
projects. Copier will create a new subdirectory there for your project.
```bash
cd ~/Developer
```

Do not create the project folder yourself -- Copier creates it for you using
the project name you provide in the next step.

### Step 2 -- Generate a new project

Run the following command from inside your projects folder:
```bash
copier copy gh:KyleFerreira/python-project-template ./your-project-name
```

Replace `your-project-name` with the name of your new project (e.g.
`inflation-db`, `curve-factory`, `my-etl-pipeline`). Copier creates a new
folder with that name and generates everything inside it.

### Step 3 -- Answer the prompts

Copier asks a series of questions to configure your project. Each question
has a default value -- press Enter to accept it, or type your own answer.
```
Project name (e.g. inflation-db)
> inflation-db

Python package name
> inflation_db

Author name
> Kyle Ferreira

Author email
> kyle.fe0212@gmail.com

Python version
> 3.11

Short project description
> A macroeconomic inflation database

License (MIT / Apache-2.0 / Proprietary)
> MIT

Include Jupyter notebooks support? (y/n)
> n

Include DuckDB support? (y/n)
> y

Include MkDocs documentation? (y/n)
> n

Include Docker support? (y/n)
> n

Include dotenv support? (y/n)
> n
```

---

## Understanding the name prompts

Two of the prompts can be confusing at first:

**Project name** is the human-readable name of your project. It is used in
the folder name, `pyproject.toml`, `README.md`, and documentation. It
typically uses hyphens as separators.
```
Example: inflation-db
```

**Python package name** is the importable name of your package in Python
code -- the name you use in `import` statements. Python package names cannot
contain hyphens, so they use underscores instead. Copier auto-suggests this
by converting your project name, so you usually just press Enter to accept it.
```
Example: inflation_db

# This is what gets used in code:
from inflation_db import something
import inflation_db
```

As a rule: project name uses hyphens (how humans refer to it), package name
uses underscores (how Python refers to it).

---

### Step 4 -- Set up your new project

Navigate into your newly generated project folder and run the setup steps:
```bash
cd your-project-name

# Install all dependencies into a local .venv folder
poetry install --with dev

# Install pre-commit hooks so checks run on every git commit
poetry run pre-commit install

# Confirm everything is working
make ci
```

If `make ci` passes with no errors, your project is fully set up.

### Step 5 -- Initialise Git and push to GitHub
```bash
git init
git branch -m master main
git add .
git commit -m "feat: initial project setup"

# Create a new empty repo on GitHub (no README, no .gitignore), then:
git remote add origin https://github.com/KyleFerreira/your-project-name.git
git push -u origin main
```

---

## Generated project structure
```
your-project-name/
├── src/
│   └── your_project_name/
│       └── __init__.py          # package entry point
├── tests/
│   ├── unit/                    # fast, isolated tests
│   ├── integration/             # slower, end-to-end tests
│   └── conftest.py              # shared pytest fixtures
├── .github/
│   ├── workflows/
│   │   └── ci.yml               # GitHub Actions CI pipeline
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml
│   │   └── feature_request.yml
│   └── PULL_REQUEST_TEMPLATE.md
├── pyproject.toml               # Poetry, Ruff, Mypy, pytest config
├── .pre-commit-config.yaml      # pre-commit hooks
├── .gitignore
├── Makefile                     # shorthand commands
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## Common commands (in generated projects)

All projects include a `Makefile` with these shortcuts:
```bash
make install    # install all dependencies via Poetry
make lint       # run Ruff linter
make format     # run Ruff formatter
make typecheck  # run Mypy type checker
make test       # run pytest with coverage report
make ci         # run all of the above in sequence
```

---

## Updating an existing project

One of Copier's best features is the ability to pull template improvements
into projects you have already created. If you improve this template later,
run the following inside any project generated from it:
```bash
cd your-existing-project
copier update
```

Copier applies the changes like a Git merge, preserving your project's
own code.

---

## Improving the template

To modify this template:
```bash
cd ~/Developer/python-project-template
# make your changes
git add .
git commit -m "feat: describe your improvement"
git push origin main
```

Changes are immediately available to all future `copier copy` runs.
Existing projects can pick them up via `copier update`.

---

## Branch strategy (in generated projects)

All generated projects follow a three-tier branch strategy:
```
main   -- production, protected
uat    -- staging / pre-release testing
dev    -- active development
```

GitHub Actions CI runs on push to all three branches and blocks PRs to
`main` and `uat` if checks fail.

---

## License

This template is for personal use. Projects generated from it carry
whichever license you choose during setup.
