# الطريقة الأسهل - Linux Desktop مع RDP في Google Colab
# انسخ هذا الكود في خلية واحدة في Colab

# تثبيت كل شيء مرة واحدة
!apt update -qq > /dev/null 2>&1
!apt install -y ubuntu-desktop-minimal -qq > /dev/null 2>&1
!apt install -y xrdp -qq > /dev/null 2>&1
!apt install -y firefox chromium-browser -qq > /dev/null 2>&1
!apt install -y code -qq > /dev/null 2>&1

# إعداد المستخدم
!useradd -m -s /bin/bash user
!echo 'user:123456' | chpasswd
!usermod -aG sudo user

# إعداد RDP
!systemctl enable xrdp
!service xrdp start

# تحميل وتشغيل النفق
!wget -q -O playit https://playit.gg/downloads/playit-linux_64
!chmod +x playit

print("🎉 إعداد RDP مكتمل!")
print("=" * 40)
print("👤 اسم المستخدم: user")
print("🔑 كلمة المرور: 123456")
print("🖥️ نظام التشغيل: Ubuntu Desktop")
print("💾 الذاكرة: 12GB+ RAM")
print("🔧 البرامج المثبتة: Firefox, Chrome, VS Code")
print("=" * 40)
print("🌐 بدء النفق...")

# بدء النفق (سيعطيك رابط للاتصال)
!./playit tcp 3389
