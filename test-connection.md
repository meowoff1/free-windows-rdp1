# 🧪 اختبار الاتصال بـ RDP

## 📋 قائمة التحقق قبل الاتصال

### ✅ تأكد من:
- [ ] تم تشغيل GitHub Action بنجاح
- [ ] ظهرت رسالة "Session is now active"
- [ ] تم الحصول على tunnel URL
- [ ] تم نسخ بيانات الاتصال

## 🔧 برامج RDP المقترحة

### Windows:
- **Remote Desktop Connection** (مدمج في Windows)
- **mRemoteNG** (مجاني ومتقدم)
- **RoyalTS** (مدفوع لكن ممتاز)

### Mac:
- **Microsoft Remote Desktop** (من App Store)
- **Royal TSX** 
- **Jump Desktop**

### Android:
- **RD Client** (Microsoft)
- **Chrome Remote Desktop**
- **TeamViewer**

### iOS:
- **RD Client** (Microsoft)
- **Jump Desktop**

## 🔍 استكشاف الأخطاء

### المشكلة: "لا يمكن الاتصال بالخادم"

**الأسباب المحتملة:**
1. الـ tunnel لم يبدأ بعد
2. URL خاطئ
3. مشكلة في الشبكة

**الحلول:**
```bash
# تحقق من حالة الـ workflow
1. اذهب إلى GitHub Actions
2. تأكد من أن الـ workflow يعمل
3. ابحث عن "PlayIt tunnel should be running"
4. انسخ الـ URL الصحيح
```

### المشكلة: "خطأ في المصادقة"

**الأسباب المحتملة:**
1. كلمة مرور خاطئة
2. اسم مستخدم خاطئ

**الحلول:**
```
Username: runneradmin
Password: RDP@GitHub2024!
```

### المشكلة: "الاتصال بطيء"

**الأسباب المحتملة:**
1. الشبكة بطيئة
2. الخادم محمل
3. إعدادات RDP

**الحلول:**
1. قلل جودة الألوان في إعدادات RDP
2. أغلق البرامج غير المطلوبة
3. جرب في وقت مختلف

## 🎯 إعدادات RDP المثلى

### للاتصال السريع:
```
Color Depth: 16-bit
Desktop Background: Disabled
Font Smoothing: Disabled
Desktop Composition: Disabled
```

### للجودة العالية:
```
Color Depth: 32-bit
Desktop Background: Enabled
Font Smoothing: Enabled
Desktop Composition: Enabled
```

## 📱 اختبار الاتصال خطوة بخطوة

### 1. Windows (Remote Desktop Connection):
```
1. اضغط Win + R
2. اكتب: mstsc
3. أدخل الـ Server: [tunnel-url]
4. اضغط Connect
5. أدخل:
   - Username: runneradmin
   - Password: RDP@GitHub2024!
```

### 2. Mac (Microsoft Remote Desktop):
```
1. افتح Microsoft Remote Desktop
2. اضغط Add PC
3. أدخل PC name: [tunnel-url]
4. أدخل User account:
   - Username: runneradmin
   - Password: RDP@GitHub2024!
5. اضغط Save ثم Connect
```

### 3. Android/iOS:
```
1. افتح RD Client
2. اضغط +
3. أدخل:
   - PC name: [tunnel-url]
   - User name: runneradmin
   - Password: RDP@GitHub2024!
4. اضغط Save ثم Connect
```

## 🔄 إعادة المحاولة

إذا فشل الاتصال:

1. **انتظر 2-3 دقائق** - قد يحتاج الـ tunnel وقت للاستقرار
2. **تحقق من الـ workflow** - تأكد أنه لا يزال يعمل
3. **جرب URL مختلف** - إذا كان هناك أكثر من tunnel
4. **أعد تشغيل الـ workflow** - ألغِ الحالي وشغل جديد

## 📊 مراقبة الأداء

### أثناء الاستخدام:
- راقب استخدام الذاكرة
- تحقق من سرعة الشبكة
- أغلق البرامج غير المطلوبة

### نصائح للأداء الأفضل:
```powershell
# تحقق من استخدام الذاكرة
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10

# تحقق من استخدام المعالج
Get-Counter "\Processor(_Total)\% Processor Time"

# تحقق من الشبكة
Test-NetConnection google.com -Port 80
```

## 🎮 اختبار الوظائف

### اختبر هذه الوظائف:
- [ ] فتح متصفح الويب
- [ ] تشغيل برنامج
- [ ] نسخ ولصق النصوص
- [ ] تحميل ملف
- [ ] تشغيل فيديو
- [ ] فتح محرر النصوص

### إذا لم تعمل وظيفة:
1. تحقق من الأذونات
2. أعد تشغيل البرنامج
3. تحقق من إعدادات RDP

## 🆘 الحصول على المساعدة

إذا واجهت مشاكل:

1. **تحقق من GitHub Issues**
2. **أنشئ issue جديد** مع:
   - وصف المشكلة
   - لقطة شاشة من الخطأ
   - نوع نظام التشغيل
   - برنامج RDP المستخدم

## ✅ نجح الاتصال؟

إذا نجح الاتصال:
- 🎉 مبروك! استمتع بـ Windows المجاني
- ⭐ اضغط Star على المشروع
- 📢 شاركه مع الأصدقاء

---

**نصيحة:** احفظ هذا الدليل للرجوع إليه لاحقاً!
