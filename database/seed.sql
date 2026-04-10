-- Sample data for Fruvelle E-commerce

-- Insert sample categories (if not exists)
INSERT INTO categories (name_ar, description) VALUES
  ('فواكه مجففة', 'فواكه مجففة طبيعياً بدون إضافات'),
  ('كاندي مجفف', 'كاندي مجفف لذيذ ومتنوع'),
  ('مارشميلو', 'مارشميلو طري وحلو'),
  ('سناكس مجففة', 'سناكس مجففة لذيذة ومقرمشة')
ON CONFLICT DO NOTHING;

-- Insert sample products
INSERT INTO products (name_ar, description_ar, price, category_id, weight, stock, is_featured, images) VALUES
  (
    'مشمش مجفف',
    'مشمش مجفف طبيعي بدون سكر مضاف، غني بالفيتامينات',
    28.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    200,
    true,
    ARRAY['https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=500']
  ),
  (
    'تين مجفف',
    'تين مجفف طبيعي، حلو المذاق وغني بالألياف',
    32.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    180,
    false,
    ARRAY['https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500']
  ),
  (
    'زبيب ذهبي',
    'زبيب ذهبي طبيعي، مصدر ممتاز للطاقة',
    22.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    250,
    false,
    ARRAY['https://images.unsplash.com/photo-1587049352846-4a222e784acc?w=500']
  ),
  (
    'قراصيا مجففة',
    'قراصيا مجففة طبيعية، مفيدة للهضم',
    26.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    160,
    false,
    ARRAY['https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?w=500']
  ),
  (
    'كاندي فواكه مجفف',
    'كاندي فواكه مجفف بنكهات متنوعة ولذيذة',
    35.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    150,
    true,
    ARRAY['https://images.unsplash.com/photo-1582058091505-f87a2e55a40f?w=500']
  ),
  (
    'كاندي جيلي مجفف',
    'كاندي جيلي مجفف بطعم الفواكه الطبيعية',
    30.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    120,
    false,
    ARRAY['https://images.unsplash.com/photo-1499195333224-3ce974eecb47?w=500']
  ),
  (
    'مارشميلو ملون',
    'مارشميلو طري وملون بألوان جذابة',
    25.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    180,
    true,
    ARRAY['https://images.unsplash.com/photo-1571506165871-ee72a35bc9d4?w=500']
  ),
  (
    'مارشميلو فانيليا',
    'مارشميلو بنكهة الفانيليا الكلاسيكية',
    22.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    200,
    false,
    ARRAY['https://images.unsplash.com/photo-1486427944299-d1955d23e34d?w=500']
  ),
  (
    'شيبس فواكه مجففة',
    'شيبس فواكه مجففة مقرمشة وصحية',
    38.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '100 جرام',
    100,
    true,
    ARRAY['https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=500']
  ),
  (
    'سناكس موز مجفف',
    'موز مجفف مقرمش ولذيذ، وجبة خفيفة مثالية',
    32.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '100 جرام',
    130,
    false,
    ARRAY['https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=500']
  );

-- Insert sample customer users
INSERT INTO users (name, phone, email, role) VALUES
  ('أحمد محمد', '0501234567', 'ahmed@example.com', 'customer'),
  ('فاطمة علي', '0509876543', 'fatima@example.com', 'customer'),
  ('محمد خالد', '0505555555', 'mohammed@example.com', 'customer'),
  ('نورة سعيد', '0507777777', 'noura@example.com', 'customer')
ON CONFLICT (phone) DO NOTHING;

-- Insert sample orders
INSERT INTO orders (customer_name, customer_phone, customer_address, total_price, status, notes) VALUES
  ('أحمد محمد', '0501234567', 'الرياض، حي النخيل، شارع الملك فهد', 110.00, 'delivered', 'توصيل سريع من فضلك'),
  ('فاطمة علي', '0509876543', 'جدة، حي الروضة، شارع الأمير سلطان', 93.00, 'shipped', ''),
  ('محمد خالد', '0505555555', 'الدمام، حي الفيصلية، شارع الخليج', 145.00, 'confirmed', 'التوصيل بعد العصر'),
  ('نورة سعيد', '0507777777', 'مكة المكرمة، حي العزيزية', 67.00, 'pending', '');

-- Insert order items for the sample orders
INSERT INTO order_items (order_id, product_id, product_name, quantity, price) VALUES
  -- Order 1
  (1, 1, 'تمر المدينة الفاخر', 2, 45.00),
  (1, 3, 'لوز محمص', 1, 35.00),
  -- Order 2
  (2, 2, 'تمر عجوة المدينة', 1, 65.00),
  (2, 6, 'مشمش مجفف', 1, 28.00),
  -- Order 3
  (3, 9, 'مشكل فواكه مجففة', 2, 38.00),
  (3, 10, 'مشكل مكسرات فاخر', 1, 58.00),
  (3, 3, 'لوز محمص', 1, 35.00),
  -- Order 4
  (4, 4, 'كاجو محمص', 1, 55.00),
  (4, 8, 'زبيب ذهبي', 1, 22.00);

COMMIT;
