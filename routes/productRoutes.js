import express from 'express';
import { supabase } from '../config/supabase.js';
import { protect, adminOnly } from '../middleware/auth.js';
import upload from '../middleware/upload.js';
import cloudinary from '../config/cloudinary.js';

const router = express.Router();

// Get all products (public)
router.get('/', async (req, res) => {
  try {
    const { category, search, featured } = req.query;
    
    let query = supabase
      .from('products')
      .select(`
        *,
        categories (name_ar)
      `);

    if (category) {
      query = query.eq('category_id', category);
    }

    if (search) {
      query = query.or(`name_ar.ilike.%${search}%,description_ar.ilike.%${search}%`);
    }

    if (featured === 'true') {
      query = query.eq('is_featured', true);
    }

    query = query.order('created_at', { ascending: false });

    const { data, error } = await query;

    if (error) throw error;

    // Format response
    const formattedData = data.map(product => ({
      ...product,
      category_name: product.categories?.name_ar
    }));

    res.json({ success: true, data: formattedData });
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب المنتجات' });
  }
});

// Get single product (public)
router.get('/:id', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('products')
      .select(`
        *,
        categories (name_ar)
      `)
      .eq('id', req.params.id)
      .single();

    if (error || !data) {
      return res.status(404).json({ success: false, message: 'المنتج غير موجود' });
    }

    const formattedData = {
      ...data,
      category_name: data.categories?.name_ar
    };

    res.json({ success: true, data: formattedData });
  } catch (error) {
    console.error('Error fetching product:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب المنتج' });
  }
});

// Create product (admin only)
router.post('/', protect, adminOnly, upload.array('images', 5), async (req, res) => {
  try {
    const { name_ar, description_ar, price, category_id, weight, stock, is_featured } = req.body;

    if (!name_ar || !price) {
      return res.status(400).json({ success: false, message: 'يرجى إدخال اسم المنتج والسعر' });
    }

    let imageUrls = [];
    if (req.files && req.files.length > 0) {
      const uploadPromises = req.files.map(file => {
        return new Promise((resolve, reject) => {
          const uploadStream = cloudinary.uploader.upload_stream(
            { folder: 'fruvelle/products' },
            (error, result) => {
              if (error) reject(error);
              else resolve(result.secure_url);
            }
          );
          uploadStream.end(file.buffer);
        });
      });
      imageUrls = await Promise.all(uploadPromises);
    }

    const { data, error } = await supabase
      .from('products')
      .insert([{
        name_ar,
        description_ar,
        price,
        category_id,
        weight,
        stock: stock || 0,
        images: imageUrls,
        is_featured: is_featured || false
      }])
      .select()
      .single();

    if (error) throw error;

    res.status(201).json({ success: true, data });
  } catch (error) {
    console.error('Error creating product:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في إضافة المنتج' });
  }
});

// Update product (admin only)
router.put('/:id', protect, adminOnly, upload.array('images', 5), async (req, res) => {
  try {
    const { name_ar, description_ar, price, category_id, weight, stock, is_featured, existing_images } = req.body;

    let imageUrls = existing_images ? JSON.parse(existing_images) : [];

    if (req.files && req.files.length > 0) {
      const uploadPromises = req.files.map(file => {
        return new Promise((resolve, reject) => {
          const uploadStream = cloudinary.uploader.upload_stream(
            { folder: 'fruvelle/products' },
            (error, result) => {
              if (error) reject(error);
              else resolve(result.secure_url);
            }
          );
          uploadStream.end(file.buffer);
        });
      });
      const newImages = await Promise.all(uploadPromises);
      imageUrls = [...imageUrls, ...newImages];
    }

    const { data, error } = await supabase
      .from('products')
      .update({
        name_ar,
        description_ar,
        price,
        category_id,
        weight,
        stock,
        images: imageUrls,
        is_featured,
        updated_at: new Date().toISOString()
      })
      .eq('id', req.params.id)
      .select()
      .single();

    if (error || !data) {
      return res.status(404).json({ success: false, message: 'المنتج غير موجود' });
    }

    res.json({ success: true, data });
  } catch (error) {
    console.error('Error updating product:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في تحديث المنتج' });
  }
});

// Delete product (admin only)
router.delete('/:id', protect, adminOnly, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('products')
      .delete()
      .eq('id', req.params.id)
      .select()
      .single();

    if (error || !data) {
      return res.status(404).json({ success: false, message: 'المنتج غير موجود' });
    }

    res.json({ success: true, message: 'تم حذف المنتج بنجاح' });
  } catch (error) {
    console.error('Error deleting product:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في حذف المنتج' });
  }
});

export default router;
