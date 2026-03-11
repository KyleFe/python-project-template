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

### Tools

Before using this template, make sure you have the following installed:
```bash
# Copier -- the tool that renders the template
brew install copier

# Poetry -- used in every generated project
brew install poetry

# Git
git --version
```

### GitHub account

You will need a GitHub account to push your projects to remote repositories
and to use GitHub Actions for CI/CD. If you do not have one, create one at
[github.com](https://github.com) before proceeding.

### One-time Git configuration

Run these once on your machine. They apply globally to all Git repositories
you create going forward:
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```

The `init.defaultBranch main` setting ensures every new repository starts on
`main` rather than `master`. This is important because the template's CI/CD
pipeline is configured around `main`, `uat`, and `dev` branches. Once this is
set globally you never need to rename branches after `git init`.

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
copier copy gh:KyleFe/python-project-template ./your-project-name
```

Replace `your-project-name` with the name of your new project (e.g.
`inflation-db`, `curve-factory`, `my-etl-pipeline`). Copier creates a new
folder with that name and generates everything inside it.

### Step 3 -- Answer the prompts

Copier asks a series of questions to configure your project. Each question
has a default value -- press Enter to accept it, or type your own answer.
```
Project name (e.g. inflation-db)
> inflation-analysis

Python package name
> inflation_analysis

Author name
> Kyle Ferreira

Author email
> kyle.fe0212@gmail.com

Python version
> 3.13

Short project description
> Analysis of exchange rate pass-through to local core inflation

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
Example: inflation-analysis
```

**Python package name** is the importable name of your package in Python
code -- the name you use in `import` statements. Python package names cannot
contain hyphens, so they use underscores instead. Copier auto-suggests this
by converting your project name, so you usually just press Enter to accept it.
```
Example: inflation_analysis

# This is what gets used in code:
from inflation_analysis import something
import inflation_analysis
```

As a rule: project name uses hyphens (how humans refer to it), package name
uses underscores (how Python refers to it).

---

### Step 4 -- Set up your virtual environment and install dependencies

After Copier generates your project, navigate into it and run:
```bash
cd your-project-name
poetry install --with dev
```

This does three things:

1. Creates a `.venv/` folder inside your project -- this is your virtual
   environment, an isolated Python installation specific to this project.
   Every project gets its own `.venv/` so packages never conflict across
   projects.

2. Installs all packages listed in `pyproject.toml` into `.venv/`.

3. Generates `poetry.lock` -- a file that pins the exact version of every
   package installed, including transitive dependencies. This ensures anyone
   else who clones the project gets identical installs. This file should be
   committed to Git.

After running `poetry install`, your project folder will contain:
```
your-project-name/
├── .venv/          -- virtual environment (gitignored, never committed)
├── poetry.lock     -- lockfile (committed to Git)
```

VS Code will detect `.venv/` automatically and use it as the Python
interpreter for the project.

### Step 5 -- Initialise Git

Before installing pre-commit hooks, Git must be initialised in the project.
```bash
git init
```

Because you set `init.defaultBranch main` globally in the one-time Git
configuration, the repository will already start on `main` -- no renaming
needed. You can confirm with:
```bash
git branch
```

### Step 6 -- Install pre-commit hooks
```bash
poetry run pre-commit install
```

This activates the pre-commit hooks so that every time you run `git commit`,
Ruff and Mypy run automatically and block the commit if there are any issues.
You only need to run this once per project, immediately after `git init`.

### Step 7 -- Confirm everything is working
```bash
make ci
```

If this passes with no errors, your project is fully set up and ready for
development.

### Step 8 -- Push to GitHub

Create a new empty repository on GitHub first:

1. Go to [github.com/new](https://github.com/new)
2. Name it to match your project name (e.g. `inflation-db`)
3. Leave it completely empty -- no README, no .gitignore, no license
4. Click Create repository

Then back in your terminal:
```bash
git add .
git commit -m "feat: initial project setup"
git remote add origin https://github.com/YOUR-USERNAME/your-project-name.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username. After this your project
is on GitHub with CI/CD active -- every push will trigger the Actions
pipeline automatically.

---

## Default packages

Every project generated from this template includes a baseline set of
packages that cover the most common development needs:

### Data manipulation and analysis
| Package | Purpose |
|---|---|
| numpy | Numerical computing, arrays, linear algebra |
| pandas | DataFrames, tabular data manipulation |
| scipy | Scientific computing, statistics, optimisation |
| statsmodels | Statistical models and hypothesis testing |
| scikit-learn | Machine learning models and utilities |

### Visualisation
| Package | Purpose |
|---|---|
| matplotlib | Core plotting library |
| matplotlib-inline | Inline plot rendering in notebooks |
| seaborn | Statistical visualisation built on matplotlib |
| plotly | Interactive charts and dashboards |

### Notebooks and kernels
| Package | Purpose |
|---|---|
| ipykernel | Jupyter kernel support |
| jupyter | Jupyter notebook environment |
| jupyterlab | Modern Jupyter interface |

### Spreadsheet and file handling
| Package | Purpose |
|---|---|
| openpyxl | Read and write Excel files |
| et-xmlfile | XML file handling (openpyxl dependency) |
| fonttools | Font file handling |
| packaging | Version and package utilities |
| pyarrow | Apache Arrow, Parquet file support |

### Utilities
| Package | Purpose |
|---|---|
| loguru | Simple, powerful logging |
| tqdm | Progress bars for loops |
| rich | Rich text and formatting in the terminal |
| python-dateutil | Extended date and time utilities |

### Conditional packages (added based on your answers)
| Package | Condition |
|---|---|
| duckdb | Added when `use_duckdb = yes` |
| python-dotenv | Added when `use_dotenv = yes` |
| nbstripout | Added when `use_notebooks = yes` |
| mkdocs-material, mkdocstrings | Added when `use_docs = yes` |

---

## Adding packages to your project

The default packages cover common needs, but every project will require
additional dependencies specific to what it does. Use Poetry to add them:
```bash
# Add a core dependency (used by the project itself)
poetry add requests
poetry add httpx
poetry add sqlalchemy

# Add a dev-only dependency (only used during development)
poetry add pytest-mock --group dev
poetry add ipdb --group dev

# Add a docs dependency
poetry add mkdocs-awesome-pages-plugin --group docs
```

When you run `poetry add`, Poetry automatically:
- Adds the package to `pyproject.toml`
- Resolves a compatible version
- Installs it into `.venv/`
- Updates `poetry.lock`

To remove a package:
```bash
poetry remove requests
```

To see all installed packages:
```bash
poetry show
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
├── .venv/                       # virtual environment (auto-created, gitignored)
├── pyproject.toml               # Poetry, Ruff, Mypy, pytest config
├── poetry.lock                  # exact dependency versions (commit this)
├── .pre-commit-config.yaml      # pre-commit hooks
├── .gitignore
├── Makefile                     # shorthand commands
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## Makefile commands

The `Makefile` provides shorthand commands so you do not have to remember or
type out full tool invocations. Instead of `poetry run ruff check .` you just
run `make lint`.

### Command reference
```bash
make install
```
Runs `poetry install --with dev`. Use this when setting up the project for
the first time, or after pulling changes that added new dependencies to
`pyproject.toml`. It installs everything into `.venv/` and updates
`poetry.lock`.
```bash
make lint
```
Runs `ruff check .`. Scans all Python files for code quality issues --
unused imports, bad patterns, style violations. Does not modify any files,
only reports problems. Use this to see what needs fixing before committing.
```bash
make format
```
Runs `ruff format .`. Automatically rewrites your Python files to conform
to the project's style rules -- indentation, line length, quote style, etc.
Run this before committing to ensure consistent formatting.
```bash
make typecheck
```
Runs `mypy src`. Statically analyses your code for type errors without
executing it. Catches bugs like passing the wrong type to a function before
they cause a runtime failure. Run this after writing new code or updating
function signatures.
```bash
make test
```
Runs `pytest` with coverage reporting. Executes all tests in `tests/unit/`
and `tests/integration/`, prints which lines of code are not covered by
tests, and fails if coverage drops below 80%. Run this to verify nothing is
broken before committing or opening a PR.
```bash
make ci
```
Runs lint, format check, typecheck, and test in sequence. This mirrors
exactly what GitHub Actions runs on every push. If `make ci` passes locally,
your push will pass CI. Run this before pushing to catch issues early.

---

### Daily development workflow

Here is how the Makefile commands fit into a typical development session:

**Starting work**
```bash
# If dependencies have changed since you last worked on the project
make install
```

**While writing code**
```bash
# After writing a new function or module
make typecheck       # catch type errors immediately

# Before committing
make format          # auto-fix formatting
make lint            # check for any remaining issues
make test            # confirm nothing is broken
```

**Before pushing or opening a PR**
```bash
# Run the full suite to confirm everything passes
make ci
```

**Typical commit rhythm**
```bash
make format          # fix formatting automatically
make ci              # confirm everything passes
git add .
git commit -m "feat: describe what you did"
git push
```

The pre-commit hooks will also run Ruff and Mypy automatically on
`git commit`, so `make format` and `make lint` act as a first pass before
the hooks fire.

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
