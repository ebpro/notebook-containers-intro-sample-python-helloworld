# Python Container Lab

This project demonstrates modern containerization patterns for Python applications:

- Classic Docker image (simple, debuggable)
- Modern production image using **uv + distroless**
- Reproducible dependency management
- Secure runtime execution

## Project Structure

```

.
├── Dockerfile            # Classic Python container (pip-based)
├── Dockerfile.stage     # Modern uv + distroless multi-stage build
├── hello.py             # Sample application
└── requirements.txt      # Python dependencies

```

## Application

`hello.py` is a simple containerized Python program:

- Uses `pandas`
- Builds a small DataFrame
- Logs output using structured logging
- Reads configuration from environment variables

Example output:

```

Hello John Doe, I'm Python running inside a container!
Here is your DataFrame:
Name  Age
0  Pierre   22
1    Paul   35
2   Marie   58

```

## 1. Classic Dockerfile (Educational Baseline)

### Purpose

This Dockerfile is designed for:

- Beginners
- Debugging
- Simple reproducibility
- Fast iteration

### Features

- Based on `python:3.13-slim`
- Uses `pip` directly
- Installs dependencies from `requirements.txt`
- Runs as non-root user

### Build

```bash
docker build -f Dockerfile -t python-classic .
```

### Run

```bash
docker run --rm \
  -e NAME="John Doe" \
  python-classic
```

## 2. Modern SOTA Dockerfile (uv + Distroless)

### Purpose

This is the **production-grade modern approach (2026)**:

* ultra-reproducible builds
* faster dependency resolution
* smaller and more secure runtime
* no shell in final image

### Key Technologies

* **uv** (Astral) → modern Python package manager
* **virtualenv isolation**
* **distroless Python runtime**
* multi-stage build

### Features

#### Build stage

* installs dependencies using `uv`
* creates isolated virtual environment in `/opt/venv`
* avoids pip runtime dependency duplication

#### Runtime stage

* uses:

  ```
  gcr.io/distroless/python3-debian12:nonroot
  ```
* no shell
* no package manager
* minimal attack surface
* runs as `nonroot`

### Build

```bash
docker build -f Dockerfile.stage -t python-sota .
```

## Run

```bash
docker run --rm \
  -e NAME="John Doe" \
  python-sota
```

## Why uv + Distroless?

| Feature          | Classic  | SOTA 2026 |
| ---------------- | -------- | --------- |
| Dependency tool  | pip      | uv        |
| Build speed      | متوسط    | very fast |
| Reproducibility  | medium   | high      |
| Image size       | large    | minimal   |
| Security         | standard | hardened  |
| Shell in runtime | yes      | no        |


## Security Model

The SOTA image follows:

* non-root execution
* no shell in runtime
* no package manager
* minimal filesystem
* explicit dependency locking via uv
