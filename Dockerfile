# --------------------------------------------------------------------
# Base image
# --------------------------------------------------------------------
FROM python:3.13-slim

# --------------------------------------------------------------------
# Build arguments (available only during image build)
# --------------------------------------------------------------------
ARG BUILD_DATE="1970-01-01T00:00:00Z"

# --------------------------------------------------------------------
# OCI image metadata
# https://github.com/opencontainers/image-spec/blob/main/annotations.md
# --------------------------------------------------------------------
LABEL org.opencontainers.image.authors="emmanuel.bruno@univ-tln.fr" \
      org.opencontainers.image.created="${BUILD_DATE}"

# --------------------------------------------------------------------
# Environment variables
# --------------------------------------------------------------------
ENV NAME="John Doe"

# --------------------------------------------------------------------
# Application directory
# --------------------------------------------------------------------
WORKDIR /app

# --------------------------------------------------------------------
# Install Python dependencies
# Copy requirements first to maximize Docker cache reuse.
# --------------------------------------------------------------------
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# --------------------------------------------------------------------
# Copy application source
# --------------------------------------------------------------------
COPY hello.py .

# --------------------------------------------------------------------
# Run as a non-root user (container security best practice)
# --------------------------------------------------------------------
RUN useradd --create-home appuser
USER appuser

# --------------------------------------------------------------------
# Default command
# --------------------------------------------------------------------
ENTRYPOINT ["python", "hello.py"]
