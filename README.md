# Ruby-Dormitory

ระบบจัดการหอพักด้วย Ruby on Rails

## เริ่มต้นใช้งาน

```bash
bundle install
bin/rails db:migrate
bin/rails server
```

จากนั้นเปิด `http://localhost:3000/login`

ข้อมูลเข้าสู่ระบบเริ่มต้น:

```text
Email: admin@dormitory.local
Password: dormitory123
```

## ฟีเจอร์

- Dashboard จัดการภาพรวมหอพัก
- เพิ่ม แก้ไข และลบห้องพัก
- จัดการผู้พักและประวัติผู้พักออก
- คำนวณค่าเช่า ค่าน้ำ และค่าไฟตามมิเตอร์
- บันทึกสถานะการชำระเงินและประวัติบิล
