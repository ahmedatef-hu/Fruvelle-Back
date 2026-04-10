import express from 'express';
import { supabase } from '../config/supabase.js';
import { protect, adminOnly } from '../middleware/auth.js';

const router = express.Router();

// Get dashboard statistics (admin only)
router.get('/stats', protect, adminOnly, async (req, res) => {
  try {
    // Total sales
    const { data: salesData, error: salesError } = await supabase
      .from('orders')
      .select('total_price')
      .neq('status', 'cancelled');

    if (salesError) throw salesError;

    const totalSales = salesData.reduce((sum, order) => sum + parseFloat(order.total_price || 0), 0);

    // Total orders
    const { count: totalOrders, error: ordersError } = await supabase
      .from('orders')
      .select('*', { count: 'exact', head: true });

    if (ordersError) throw ordersError;

    // Total users
    const { count: totalUsers, error: usersError } = await supabase
      .from('users')
      .select('*', { count: 'exact', head: true })
      .eq('role', 'customer');

    if (usersError) throw usersError;

    // Top selling products
    const { data: orderItems, error: itemsError } = await supabase
      .from('order_items')
      .select(`
        product_id,
        quantity,
        products (id, name_ar, images)
      `);

    if (itemsError) throw itemsError;

    // Aggregate quantities by product
    const productSales = {};
    orderItems.forEach(item => {
      if (item.products) {
        const productId = item.product_id;
        if (!productSales[productId]) {
          productSales[productId] = {
            id: item.products.id,
            name_ar: item.products.name_ar,
            images: item.products.images,
            total_sold: 0
          };
        }
        productSales[productId].total_sold += item.quantity;
      }
    });

    const topProducts = Object.values(productSales)
      .sort((a, b) => b.total_sold - a.total_sold)
      .slice(0, 5);

    // Recent orders
    const { data: recentOrders, error: recentError } = await supabase
      .from('orders')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(10);

    if (recentError) throw recentError;

    res.json({
      success: true,
      data: {
        totalSales,
        totalOrders: totalOrders || 0,
        totalUsers: totalUsers || 0,
        topProducts,
        recentOrders,
      },
    });
  } catch (error) {
    console.error('Error fetching dashboard stats:', error);
    res.status(500).json({ success: false, message: 'حدث خطأ في جلب الإحصائيات' });
  }
});

export default router;
