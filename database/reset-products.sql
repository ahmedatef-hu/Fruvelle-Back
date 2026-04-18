-- Delete all existing products
DELETE FROM order_items;
DELETE FROM products;

-- Reset the sequence
ALTER SEQUENCE products_id_seq RESTART WITH 1;

-- Insert new products
INSERT INTO products (name_ar, description_ar, price, category_id, weight, stock, is_featured, images) VALUES
  -- فواكه مجففة
  (
    'مشمش مجفف',
    'مشمش مجفف طبيعي بدون سكر مضاف، غني بالفيتامينات',
    28.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    200,
    true,
    ARRAY['https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=800&q=80']
  ),
  (
    'تين مجفف',
    'تين مجفف طبيعي، حلو المذاق وغني بالألياف',
    32.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    180,
    false,
    ARRAY['https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=800&q=80']
  ),
  (
    'قراصيا مجففة',
    'قراصيا مجففة طبيعية، مفيدة للهضم',
    26.00,
    (SELECT id FROM categories WHERE name_ar = 'فواكه مجففة' LIMIT 1),
    '250 جرام',
    160,
    false,
    ARRAY['https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?w=800&q=80']
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
    ARRAY['https://images.unsplash.com/photo-1582058091505-f87a2e55a40f?w=800&q=80']
  ),
  (
    'كاندي جيلي ملون',
    'كاندي جيلي مجفف بطعم الفواكه الطبيعية وألوان جذابة',
    30.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    120,
    false,
    ARRAY['https://images.unsplash.com/photo-1499195333224-3ce974eecb47?w=800&q=80']
  ),
  (
    'كاندي مانجو مجفف',
    'شرائح مانجو مجففة حلوة ولذيذة، طعم استوائي رائع',
    38.00,
    (SELECT id FROM categories WHERE name_ar = 'كاندي مجفف' LIMIT 1),
    '200 جرام',
    100,
    false,
    ARRAY['https://images.unsplash.com/photo-1605027990121-cbae9e0642df?w=800&q=80']
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
    ARRAY['https://images.unsplash.com/photo-1571506165871-ee72a35bc9d4?w=800&q=80']
  ),
  (
    'مارشميلو فانيليا',
    'مارشميلو بنكهة الفانيليا الكلاسيكية الطرية',
    22.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    200,
    false,
    ARRAY['https://images.unsplash.com/photo-1486427944299-d1955d23e34d?w=800&q=80']
  ),
  (
    'مارشميلو بالفراولة',
    'مارشميلو بنكهة الفراولة اللذيذة، طري ومميز',
    24.00,
    (SELECT id FROM categories WHERE name_ar = 'مارشميلو' LIMIT 1),
    '150 جرام',
    160,
    false,
    ARRAY['https://images.unsplash.com/photo-1548848979-47519fe73dca?w=800&q=80']
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
    ARRAY['https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=800&q=80']
  ),
  (
    'شيبس موز مجفف',
    'موز مجفف مقرمش ولذيذ، وجبة خفيفة مثالية',
    30.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '100 جرام',
    130,
    false,
    ARRAY['https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=800&q=80']
  ),
  (
    'مكس فواكه مجففة',
    'تشكيلة متنوعة من الفواكه المجففة المقرمشة',
    35.00,
    (SELECT id FROM categories WHERE name_ar = 'سناكس مجففة' LIMIT 1),
    '150 جرام',
    110,
    false,
    ARRAY['https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=800&q=80']
  );