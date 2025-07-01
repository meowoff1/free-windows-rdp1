# Google Colab RDP Setup - Linux Desktop
# انسخ هذا الكود في Google Colab

# الخطوة 1: تثبيت Desktop Environment
!apt update
!apt install -y xfce4 xfce4-goodies
!apt install -y xrdp
!apt install -y firefox

# الخطوة 2: إعداد RDP
!systemctl enable xrdp
!adduser colab --disabled-password --gecos ""
!echo 'colab:password123' | chpasswd
!usermod -aG sudo colab
!service xrdp start

# الخطوة 3: تثبيت ngrok البديل (playit.gg)
!wget -O playit https://playit.gg/downloads/playit-linux_64
!chmod +x playit

print("🖥️ Linux Desktop RDP Setup Complete!")
print("👤 Username: colab")
print("🔑 Password: password123")
print("🌐 Starting tunnel...")

# الخطوة 4: بدء النفق
!./playit tcp 3389
