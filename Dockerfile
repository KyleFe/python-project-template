FROM python:{{ python_version }}-slim

WORKDIR /app

RUN pip install poetry

COPY pyproject.toml poetry.lock* ./
RUN poetry install --only main --no-interaction --no-ansi

COPY src/ ./src/

CMD ["python", "-m", "{{ package_name }}"]
