from app import app

# Конфигурация для Gunicorn
bind = "0.0.0.0:10000"
workers = 1
worker_class = "sync"
timeout = 120  # Увеличиваем таймаут до 2 минут

if __name__ == "__main__":
    app.run()
