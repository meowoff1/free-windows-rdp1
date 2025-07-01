# Google Colab Windows RDP Setup
# انسخ هذا الكود في Google Colab

import os
import subprocess
import time

print("🚀 Setting up Windows RDP in Google Colab...")

# الخطوة 1: تثبيت QEMU والأدوات المطلوبة
!apt update -qq
!apt install -y qemu-kvm qemu-utils

# الخطوة 2: تحميل Windows ISO (مجاني من Microsoft)
print("📥 Downloading Windows ISO...")
!wget -O windows.iso "https://software-download.microsoft.com/download/pr/Win10_22H2_Arabic_x64.iso"

# الخطوة 3: إنشاء قرص صلب افتراضي
!qemu-img create -f qcow2 windows.qcow2 20G

# الخطوة 4: تثبيت أدوات النفق
!wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
!chmod +x cloudflared

# الخطوة 5: بدء Windows VM
print("🖥️ Starting Windows Virtual Machine...")
vm_process = subprocess.Popen([
    'qemu-system-x86_64',
    '-m', '4G',
    '-smp', '2',
    '-hda', 'windows.qcow2',
    '-cdrom', 'windows.iso',
    '-boot', 'd',
    '-vnc', ':1',
    '-netdev', 'user,id=net0,hostfwd=tcp::3389-:3389',
    '-device', 'e1000,netdev=net0'
], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

print("✅ Windows VM started!")
print("🔗 Connect via VNC on port 5901 for installation")
print("🖥️ RDP will be available on port 3389 after Windows setup")

# الخطوة 6: إعداد النفق
print("🌐 Setting up tunnel...")
# يمكنك إضافة Cloudflare token هنا
# !./cloudflared tunnel --url tcp://localhost:3389

print("📋 Setup Instructions:")
print("1. Install Windows through VNC")
print("2. Enable RDP in Windows")
print("3. Use the tunnel URL to connect")
