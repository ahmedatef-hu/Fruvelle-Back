-- Delete all existing products
DELETE FROM order_items;
DELETE FROM products;

-- Reset the sequence
ALTER SEQUENCE products_id_seq RESTART WITH 1;

-- Insert new products
INSERT INTO products (name_ar, description_ar, price, category_id, weight, stock, is_featured, images) VALUES
  -- فواكه مجففة
  (
    'تمر المدينة الفاخر',
    'تمر المدينة المنورة الفاخر، طري ولذيذ، غني بالفيتامينات والمعادن',
    45.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '500 جرام',
    200,
    true,
    ARRAY['https://images.pexels.com/photos/4022092/pexels-photo-4022092.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'تمر عجوة المدينة',
    'تمر عجوة المدينة الأصلي، معروف بفوائده الصحية العديدة',
    65.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '500 جرام',
    150,
    true,
    ARRAY['https://images.pexels.com/photos/4022091/pexels-photo-4022091.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'مشمش مجفف',
    'مشمش مجفف طبيعي بدون سكر مضاف، غني بالفيتامينات',
    28.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    200,
    true,
    ARRAY['https://images.pexels.com/photos/8969237/pexels-photo-8969237.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'تين مجفف',
    'تين مجفف طبيعي، حلو المذاق وغني بالألياف',
    32.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    180,
    false,
    ARRAY['https://images.pexels.com/photos/5966630/pexels-photo-5966630.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'زبيب ذهبي',
    'زبيب ذهبي طبيعي، مصدر ممتاز للطاقة',
    22.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    250,
    false,
    ARRAY['https://images.pexels.com/photos/4022090/pexels-photo-4022090.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'قراصيا مجففة',
    'قراصيا مجففة طبيعية، مفيدة للهضم',
    26.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    160,
    false,
    ARRAY['https://images.pexels.com/photos/8969239/pexels-photo-8969239.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  
  -- كاندي مجفف
  (
    'كاندي فواكه استوائية',
    'كاندي فواكه استوائية مجففة بنكهات متنوعة ولذيذة',
    35.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    150,
    true,
    ARRAY['https://images.pexels.com/photos/3723575/pexels-photo-3723575.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'كاندي جيلي ملون',
    'كاندي جيلي مجفف بطعم الفواكه الطبيعية وألوان جذابة',
    30.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    120,
    false,
    ARRAY['https://images.pexels.com/photos/3723574/pexels-photo-3723574.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'كاندي مانجو مجفف',
    'شرائح مانجو مجففة حلوة ولذيذة، طعم استوائي رائع',
    38.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    100,
    false,
    ARRAY['https://images.pexels.com/photos/5966631/pexels-photo-5966631.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  
  -- مارشميلو
  (
    'مارشميلو ملون كبير',
    'مارشميلو طري وملون بألوان جذابة، حجم كبير',
    25.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    180,
    true,
    ARRAY['https://images.pexels.com/photos/4022092/pexels-photo-4022092.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'مارشميلو فانيليا',
    'مارشميلو بنكهة الفانيليا الكلاسيكية الطرية',
    22.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    200,
    false,
    ARRAY['https://images.pexels.com/photos/4022091/pexels-photo-4022091.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'مارشميلو بالفراولة',
    'مارشميلو بنكهة الفراولة اللذيذة، طري ومميز',
    24.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    160,
    false,
    ARRAY['https://images.pexels.com/photos/3723575/pexels-photo-3723575.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  
  -- سناكس مجففة
  (
    'شيبس تفاح مجفف',
    'شيبس تفاح مجفف مقرمش وصحي، بدون سكر مضاف',
    32.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '100 جرام',
    140,
    true,
    ARRAY['https://images.pexels.com/photos/5966631/pexels-photo-5966631.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'شيبس موز مجفف',
    'موز مجفف مقرمش ولذيذ، وجبة خفيفة مثالية',
    30.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '100 جرام',
    130,
    false,
    ARRAY['https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=800']
  ),
  (
    'مكس فواكه مجففة',
    'تشكيلة متنوعة من الفواكه المجففة المقرمشة',
    35.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '150 جرام',
    110,
    false,
    ARRAY['https://images.pexels.com/photos/8969237/pexels-photo-8969237.jpeg?auto=compress&cs=tinysrgb&w=800']
  );

COMMIT;
