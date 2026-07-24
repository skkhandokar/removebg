# ১. বেস ইমেজ হিসেবে Python ৩.১০
FROM python:3.10-slim

# ২. কনটেইনারের ভেতরের ওয়ার্কিং ডিরেক্টরির নাম নির্ধারণ
WORKDIR /removebg

# ৩. rembg ও ইমেজ প্রসেসিংয়ের প্রয়োজনীয় সিস্টেম প্যাকেজ ইন্সটল
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ৪. requirements.txt কপি করে পাইথন প্যাকেজ ইন্সটল
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ৫. লোকাল প্রজেক্টের সব ফাইল ডকারের /removebg ফোল্ডারে কপি
COPY . .

# ৬. Gunicorn দিয়ে Django প্রজেক্ট স্টার্ট করা
CMD ["gunicorn", "bg_remover_api.wsgi:application", "--bind", "0.0.0.0:8000"]