# ১. বেস ইমেজ হিসেবে Python ৩.১০
FROM python:3.10-slim

# ২. ওয়ার্কিং ডিরেক্টরি
WORKDIR /removebg

# ৩. আপডেট করা সিস্টেম প্যাকেজ (libgl1-mesa-glx এর জায়গায় libgl1 ব্যবহার করা হয়েছে)
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# ৪. requirements.txt কপি ও ইন্সটল
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ৫. সব ফাইল কপি করা
COPY . .

# ৬. Gunicorn রান করা (আপনার প্রজেক্টের আসল নাম অনুযায়ী bg_remover_api পরিবর্তন করে নেবেন)
CMD ["gunicorn", "bg_remover_api.wsgi:application", "--bind", "0.0.0.0:8000"]