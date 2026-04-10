-- Update all product images to use working Pexels images
-- This will fix the ERR_CONNECTION_CLOSED error

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/4022092/pexels-photo-4022092.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%تمر%' OR name_ar LIKE '%مشمش%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/5966630/pexels-photo-5966630.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%تين%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/4022090/pexels-photo-4022090.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%زبيب%' OR name_ar LIKE '%لوز%' OR name_ar LIKE '%كاجو%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/8969239/pexels-photo-8969239.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%قراصيا%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/3723575/pexels-photo-3723575.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%كاندي%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/4022092/pexels-photo-4022092.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%مارشميلو%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/5966631/pexels-photo-5966631.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%شيبس%' OR name_ar LIKE '%سناكس%';

UPDATE products SET images = ARRAY['https://images.pexels.com/photos/8969237/pexels-photo-8969237.jpeg?auto=compress&cs=tinysrgb&w=800'] WHERE name_ar LIKE '%مكس%' OR name_ar LIKE '%مشكل%';

COMMIT;
