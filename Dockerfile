FROM python:3.12-slim@sha256:78387bc3881b8273120a12ebe6c1ab22b018ccc2c9adf565ae1ac9b536e184ea

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN useradd --uid 10001 --no-create-home appuser

COPY app/ ./app/

USER appuser

EXPOSE 8080

CMD ["gunicorn", "--chdir", "app", "--bind", "0.0.0.0:8080", "--workers", "2", "app:app"]
