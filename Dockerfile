# 🚫 BAD PRACTICES — for demonstration only

# 1️⃣ Use unpinned base image (no version specified)
FROM ubuntu:latest

# 2️⃣ Run as root user (default)
USER root

# 3️⃣ Install packages without cleaning cache
RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    vim \
    netcat \
    iputils-ping

# 4️⃣ Copy sensitive files directly into image
COPY ./config/ /etc/myapp/
COPY ./secrets.txt /root/

# 5️⃣ No verification of downloaded binaries
RUN curl -o /usr/local/bin/app https://example.com/myapp && chmod +x /usr/local/bin/app

# 6️⃣ No HEALTHCHECK (cannot track container health)
# 7️⃣ No non-root user or permissions adjustment
# 8️⃣ Exposes unnecessary ports
EXPOSE 22 8080 9090

# 9️⃣ CMD runs as root and uses bash shell
CMD ["/bin/bash", "-c", "python3 /etc/myapp/start.py"]
