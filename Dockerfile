# BAD PRACTICE: use latest tag (never pinned)
FROM python:latest

# BAD PRACTICE: running as root user
USER root

# BAD PRACTICE: install packages with no checks
RUN apt-get update && apt-get install -y wget curl vim

# BAD PRACTICE: disable security updates
RUN rm -f /etc/apt/sources.list.d/security.list || true

# BAD PRACTICE: copy sensitive data into image
COPY secret-key.txt /app/secret-key.txt

WORKDIR /app

# BAD PRACTICE: no version pinning in requirements
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY . /app

# BAD PRACTICE: expose internal ports publicly
EXPOSE 80

# BAD PRACTICE: no healthcheck
CMD ["python3", "app.py"]
