# Use slim Python base
FROM python:3.13-slim

# Install system deps for PostgreSQL
RUN apt-get update && apt-get install -y \
    pkg-config \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy uv binary
COPY --from=ghcr.io/astral-sh/uv:0.9.5 /uv /uvx /bin/

# Set env vars
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set workdir
WORKDIR /uvfastapipostgredocker

# Copy dependency files
COPY pyproject.toml /uvfastapipostgredocker/
COPY uv.lock /uvfastapipostgredocker/

# Install deps
RUN uv sync --locked

# Copy project files
COPY . /uvfastapipostgredocker/


