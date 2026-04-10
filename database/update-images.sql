-- Update product images to match product names

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/8969237/pexels-photo-8969237.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'مشمش مجفف';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/5966630/pexels-photo-5966630.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'تين مجفف';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/4022090/pexels-photo-4022090.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'زبيب ذهبي';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/8969239/pexels-photo-8969239.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'قراصيا مجففة';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/3723575/pexels-photo-3723575.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'كاندي فواكه مجفف';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/3723574/pexels-photo-3723574.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'كاندي جيلي مجفف';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/4022092/pexels-photo-4022092.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'مارشميلو ملون';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/4022091/pexels-photo-4022091.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'مارشميلو فانيليا';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/5966631/pexels-photo-5966631.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'شيبس فواكه مجففة';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar = 'سناكس موز مجفف';

COMMIT;
