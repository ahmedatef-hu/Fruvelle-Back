import express from 'express';
import { supabase } from '../config/supabase.js';
import { protect, adminOnly } from '../middleware/auth.js';

const router = express.Router();

// Get all users (admin only)
router.get('/', protect, adminOnly, async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('users')
      .select('id, name, phone, email, role, created_at')
      .order('created_at', { ascending: false });

    if (error) throw error;

    res.json({ success: true, data });
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب المستخدمين' });
  }
});

export default router;
