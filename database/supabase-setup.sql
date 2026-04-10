-- Fruvelle E-commerce Database Schema for Supabase
-- Run this in Supabase SQL Editor

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL UNIQUE,
  email VARCHAR(255),
  password VARCHAR(255),
  role VARCHAR(20) DEFAULT 'customer',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  name_ar VARCHAR(255) NOT NULL,
  description TEXT,
  image VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  name_ar VARCHAR(255) NOT NULL,
  description TEXT,
  description_ar TEXT,
  price DECIMAL(10, 2) NOT NULL,
  category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
  weight VARCHAR(50),
  stock INTEGER DEFAULT 0,
  images TEXT[],
  is_featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,
  customer_phone VARCHAR(20) NOT NULL,
  customer_address TEXT NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
  product_id INTEGER REFERENCES products(id) ON DELETE SET NULL,
  product_name VARCHAR(255) NOT NULL,
  quantity INTEGER NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);

-- Insert default categories
INSERT INTO categories (name, name_ar, description) VALUES
  ('Dates', 'تمور', 'Premium quality dates'),
  ('Nuts', 'مكسرات', 'Fresh and crunchy nuts'),
  ('Dried Fruits', 'فواكه مجففة', 'Naturally dried fruits'),
  ('Mixed', 'مشكل', 'Mixed dried fruits and nuts')
ON CONFLICT DO NOTHING;

-- Insert sample products with placeholder images
INSERT INTO products (name, name_ar, description, description_ar, price, category_id, weight, stock, is_featured, images) VALUES
  (
    'Premium Madinah Dates',
    'تمر المدينة الفاخر',
    'Premium quality dates from Madinah',
    'تمر المدينة المنورة الفاخر، طري ولذيذ، غني بالفيتامينات والمعادن',
    45.00,
    1,
    '500 جرام',
    100,
    true,
    ARRAY['https://images.unsplash.com/photo-1577003833154-a3d4c90f9b5d?w=500']
  ),
  (
    'Ajwa Dates',
    'تمر عجوة المدينة',
    'Original Ajwa dates from Madinah',
    'تمر عجوة المدينة الأصلي، معروف بفوائده الصحية العديدة',
    65.00,
    1,
    '500 جرام',
    80,
    true,
    ARRAY['https://images.unsplash.com/photo-1609501676725-7186f017a4b7?w=500']
  ),
  (
    'Roasted Almonds',
    'لوز محمص',
    'Roasted almonds without salt',
    'لوز محمص بدون ملح، غني بالبروتين والألياف',
    35.00,
    2,
    '250 جرام',
    150,
    true,
    ARRAY['https://images.unsplash.com/photo-1508747703725-719777637510?w=500']
  ),
  (
    'Roasted Cashews',
    'كاجو محمص',
    'Premium roasted cashews',
    'كاجو محمص فاخر، طعم رائع وقيمة غذائية عالية',
    55.00,
    2,
    '250 جرام',
    120,
    false,
    ARRAY['https://images.unsplash.com/photo-1585704032915-c3400ca199e7?w=500']
  ),
  (
    'Dried Apricots',
    'مشمش مجفف',
    'Natural dried apricots without added sugar',
    'مشمش مجفف طبيعي بدون سكر مضاف، غني بالفيتامينات',
    28.00,
    3,
    '250 جرام',
    200,
    true,
    ARRAY['https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=500']
  ),
  (
    'Mixed Dried Fruits',
    'مشكل فواكه مجففة',
    'Variety of natural dried fruits',
    'تشكيلة متنوعة من الفواكه المجففة الطبيعية',
    38.00,
    4,
    '500 جرام',
    100,
    true,
    ARRAY['https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=500']
  )
ON CONFLICT DO NOTHING;

-- Note: Admin user will be created using npm run create-admin
-- This ensures proper password hashing
