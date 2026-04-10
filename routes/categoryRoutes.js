import express from 'express';
import { supabase } from '../config/supabase.js';
import { protect, adminOnly } from '../middleware/auth.js';

const router = express.Router();

// Get all categories (public)
router.get('/', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('categories')
      .select('*')
      .order('name_ar');

    if (error) throw error;

    res.json({ success: true, data });
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب الفئات' });
  }
});

// Create category (admin only)
router.post('/', protect, adminOnly, async (req, res) => {
  try {
    const { name_ar, description } = req.body;

    if (!name_ar) {
      return res.status(400).json({ success: false, message: 'يرجى إدخال اسم الفئة' });
    }

    const { data, error } = await supabase
      .from('categories')
      .insert([{ name_ar, description }])
      .select()
      .single();

    if (error) throw error;

    res.status(201).json({ success: true, data });
  } catch (error) {
    console.error('Error creating category:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في إضافة الفئة' });
  }
});

// Delete category (admin only)
router.delete('/:id', protect, adminOnly, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('categories')
      .delete()
      .eq('id', req.params.id)
      .select()
      .single();

    if (error || !data) {
      return res.status(404).json({ success: false, message: 'الفئة غير موجودة' });
    }

    res.json({ success: true, message: 'تم حذف الفئة بنجاح' });
  } catch (error) {
    console.error('Error deleting category:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في حذف الفئة' });
  }
});

export default router;
