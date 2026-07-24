FROM python:3.10-slim

WORKDIR /removebg

# বিল্ডের জন্য প্রয়োজনীয় ডিপেন্ডেন্সি এবং C-libraries ইন্সটল
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    build-essential \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# pip আপডেট করা
RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "bg_remover_api.wsgi:application", "--bind", "0.0.0.0:8000"]