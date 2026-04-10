import express from 'express';
import { supabase } from '../config/supabase.js';
import { protect, adminOnly } from '../middleware/auth.js';

const router = express.Router();

// Create order (public)
router.post('/', async (req, res) => {
  try {
    const { customer_name, customer_phone, customer_address, items, total_price, notes } = req.body;

    if (!customer_name || !customer_phone || !customer_address || !items || items.length === 0) {
      return res.status(400).json({ success: false, message: 'يرجى إدخال جميع البيانات المطلوبة' });
    }

    // Create order
    const { data: order, error: orderError } = await supabase
      .from('orders')
      .insert([{
        customer_name,
        customer_phone,
        customer_address,
        total_price,
        notes
      }])
      .select()
      .single();

    if (orderError) throw orderError;

    // Create order items
    const orderItems = items.map(item => ({
      order_id: order.id,
      product_id: item.product_id,
      product_name: item.product_name,
      quantity: item.quantity,
      price: item.price
    }));

    const { error: itemsError } = await supabase
      .from('order_items')
      .insert(orderItems);

    if (itemsError) throw itemsError;

    res.status(201).json({ success: true, data: order, message: 'تم إرسال طلبك بنجاح' });
  } catch (error) {
    console.error('Error creating order:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في إنشاء الطلب' });
  }
});

// Get all orders (admin only)
router.get('/', protect, adminOnly, async (req, res) => {
  try {
    const { status } = req.query;
    
    let query = supabase
      .from('orders')
      .select('*');

    if (status) {
      query = query.eq('status', status);
    }

    query = query.order('created_at', { ascending: false });

    const { data, error } = await query;

    if (error) throw error;

    res.json({ success: true, data });
  } catch (error) {
    console.error('Error fetching orders:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب الطلبات' });
  }
});

// Get single order with items (admin only)
router.get('/:id', protect, adminOnly, async (req, res) => {
  try {
    const { data: order, error: orderError } = await supabase
      .from('orders')
      .select('*')
      .eq('id', req.params.id)
      .single();

    if (orderError || !order) {
      return res.status(404).json({ success: false, message: 'الطلب غير موجود' });
    }

    const { data: items, error: itemsError } = await supabase
      .from('order_items')
      .select('*')
      .eq('order_id', req.params.id);

    if (itemsError) throw itemsError;

    res.json({
      success: true,
      data: {
        ...order,
        items,
      },
    });
  } catch (error) {
    console.error('Error fetching order:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب الطلب' });
  }
});

// Update order status (admin only)
router.put('/:id/status', protect, adminOnly, async (req, res) => {
  try {
    const { status } = req.body;
    const validStatuses = ['pending', 'confirmed', 'shipped', 'delivered', 'cancelled'];

    if (!validStatuses.includes(status)) {
      return res.status(400).json({ success: false, message: 'حالة الطلب غير صحيحة' });
    }

    const { data, error } = await supabase
      .from('orders')
      .update({
        status,
        updated_at: new Date().toISOString()
      })
      .eq('id', req.params.id)
      .select()
      .single();

    if (error || !data) {
      return res.status(404).json({ success: false, message: 'الطلب غير موجود' });
    }

    res.json({ success: true, data });
  } catch (error) {
    console.error('Error updating order status:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في تحديث حالة الطلب' });
  }
});

export default router;
