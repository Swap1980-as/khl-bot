import smtplib
import os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import datetime
from flask import Flask

app = Flask(__name__)

def send_khl_email():
    try:
        # Настройки почты
        smtp_server = "smtp.mail.ru"
        smtp_port = 587
        email_from = "khl.bot@mail.ru"
        password = "b62ug5fzFOLQP2AVTbD6"
        email_to = "swap1980@mail.ru"
        
        # Создаем письмо
        msg = MIMEMultipart()
        msg['Subject'] = f"🏒 КХЛ Матчи - {datetime.datetime.now().strftime('%d.%m.%Y')}"
        msg['From'] = email_from
        msg['To'] = email_to
        
        # Текст письма
        html = f"""
        <html>
        <body style="font-family: Arial; margin: 20px;">
            <h2>🏒 Утренний обзор КХЛ</h2>
            <p>Доброе утро! Ваша сводка на {datetime.datetime.now().strftime('%d.%m.%Y')}</p>
            
            <div style="background: #f8f9fa; padding: 15px; margin: 10px 0; border-radius: 8px;">
                <h3>📋 Сегодняшние матчи:</h3>
                <p>• <strong>ЦСКА vs СКА</strong> - 19:30 МСК</p>
                <p>• <strong>Ак Барс vs Салават Юлаев</strong> - 17:00 МСК</p>
                <p>• <strong>Динамо vs Локомотив</strong> - 19:00 МСК</p>
            </div>
            
            <p><small>Автоматическая рассылка в 8:00</small></p>
        </body>
        </html>
        """
        
        msg.attach(MIMEText(html, 'html'))
        
        # Отправка
        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(email_from, password)
        server.send_message(msg)
        server.quit()
        
        print("✅ Письмо отправлено!")
        return True
        
    except Exception as e:
        print(f"❌ Ошибка: {e}")
        return False

@app.route('/')
def home():
    return "🏒 КХЛ Бот работает! Используйте /send-test для теста"

@app.route('/send-test')
def send_test():
    result = send_khl_email()
    return "✅ Тестовое письмо отправлено!" if result else "❌ Ошибка отправки"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
