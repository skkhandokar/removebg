# Python Base Image
FROM python:3.10-slim

# পরিবেশের ভ্যারিয়েবল সেটআপ
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# কাজের ডিরেক্টরি
WORKDIR /app

# সিস্টেম ডিফেন্ডেন্সি (LibreOffice ও Poppler) ইনস্টল
RUN apt-get update && apt-get install -y \
    libreoffice \
    poppler-utils \
    ffmpeg \
    libsm6 \
    libxext6 \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Requirements ফাইল কপি ও Python প্যাকজ ইনস্টল
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# প্রজেক্টের সব ফাইল কপি
COPY . /app/

# Port এক্সপোজ করা
EXPOSE 8000

# Django Server রান করার কমান্ড
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]