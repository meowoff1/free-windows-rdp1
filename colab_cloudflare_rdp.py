# Google Colab + Cloudflare Tunnel RDP
# ضع Cloudflare Token الخاص بك في المتغير أدناه

CLOUDFLARE_TOKEN = "YOUR_CLOUDFLARE_TOKEN_HERE"  # ضع token هنا

import os
import subprocess
import time

print("🚀 إعداد RDP مع Cloudflare Tunnel...")

# تثبيت Desktop Environment
!apt update -qq
!apt install -y xfce4 xfce4-goodies xrdp firefox -qq

# إعداد المستخدم
!useradd -m -s /bin/bash rdpuser
!echo 'rdpuser:MyPassword123!' | chpasswd
!usermod -aG sudo rdpuser

# بدء خدمة RDP
!service xrdp start

# تحميل Cloudflared
!wget -q -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
!chmod +x cloudflared

print("✅ إعداد RDP مكتمل!")
print("👤 Username: rdpuser")
print("🔑 Password: MyPassword123!")

if CLOUDFLARE_TOKEN != "YOUR_CLOUDFLARE_TOKEN_HERE":
    print("🌐 بدء Cloudflare Tunnel...")
    # بدء النفق
    tunnel_process = subprocess.Popen([
        './cloudflared', 'tunnel', '--no-autoupdate', 'run', '--token', CLOUDFLARE_TOKEN
    ])
    print("🔗 النفق يعمل! تحقق من Cloudflare Dashboard للحصول على الرابط")
else:
    print("⚠️ يرجى إضافة Cloudflare Token في المتغير CLOUDFLARE_TOKEN")
    print("📝 احصل على Token من: https://one.dash.cloudflare.com/")

# إبقاء الجلسة نشطة
print("⏰ الجلسة ستبقى نشطة لمدة 12 ساعة...")
try:
    while True:
        time.sleep(300)  # فحص كل 5 دقائق
        print(f"🟢 الجلسة نشطة - الوقت: {time.strftime('%H:%M:%S')}")
except KeyboardInterrupt:
    print("🛑 تم إيقاف الجلسة")
