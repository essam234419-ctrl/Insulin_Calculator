FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    SCHOOL_ENV=production
WORKDIR /app
COPY deploy /tmp/deploy
RUN cat /tmp/deploy/app.b64.* | base64 -d > /tmp/app.zip \
 && python -c "import zipfile; zipfile.ZipFile('/tmp/app.zip').extractall('/app')" \
 && rm -rf /tmp/deploy /tmp/app.zip \
 && mkdir -p /app/data /app/uploads /app/backups
EXPOSE 8080
CMD ["python","app.py"]
