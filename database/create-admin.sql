-- إنشاء حساب المسؤول
-- شغّل هذا في Supabase SQL Editor

-- كلمة المرور: admin123
-- الهاتف: 0500000000

INSERT INTO users (name, phone, email, password, role) 
VALUES (
  'Admin',
  '0500000000',
  'admin@fruvelle.com',
  '$2a$10$rKvVJKhPqPZqYqXqYqXqYOZqYqXqYqXqYqXqYqXqYqXqYqXqYqXqY',
  'admin'
) 
ON CONFLICT (phone) 
DO UPDATE SET 
  password = EXCLUDED.password,
  role = EXCLUDED.role;

-- تحقق من إنشاء المسؤول
SELECT id, name, phone, email, role FROM users WHERE role = 'admin';
