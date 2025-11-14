# ---------------------------
# Stage 1: Build environment
# ---------------------------
FROM python:3.11-slim AS builder

# Set working directory
WORKDIR /app

# Copy only requirements first (for efficient caching)
COPY requirements.txt .

# Install dependencies (no cache to reduce image size)
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY . .

# ---------------------------
# Stage 2: Runtime environment
# ---------------------------
FROM python:3.11-slim

# Create a non-root user
RUN useradd -m appuser

# Set working directory
WORKDIR /app

# Copy installed dependencies and source code from builder
COPY --from=builder /app /app

# Switch to non-root user
USER appuser

# Expose application port
EXPOSE 8000

# Add a health check
HEALTHCHECK CMD curl -f http://localhost:8000/health || exit 1

# Use exec form for CMD
CMD ["python", "app.py"]
