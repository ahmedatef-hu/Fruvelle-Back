-- Fix product categories - assign correct category_id to each product

-- First, let's see what category IDs we have
-- Category 1 = فواكه مجففة
-- Category 2 = كاندي مجفف  
-- Category 3 = مارشميلو
-- Category 4 = سناكس مجففة

-- Update فواكه مجففة products to category 1
UPDATE products SET category_id = 1 
WHERE name_ar IN ('مشمش مجفف', 'تين مجفف', 'قراصيا مجففة', 'تمر المدينة الفاخر', 'تمر عجوة المدينة', 'زبيب ذهبي');

-- Update كاندي مجفف products to category 2
UPDATE products SET category_id = 2 
WHERE name_ar LIKE '%كاندي%';

-- Update مارشميلو products to category 3
UPDATE products SET category_id = 3 
WHERE name_ar LIKE '%مارشميلو%';

-- Update سناكس مجففة products to category 4
UPDATE products SET category_id = 4 
WHERE name_ar LIKE '%شيبس%' OR name_ar LIKE '%سناكس%' OR name_ar LIKE '%مكس%';

COMMIT;
