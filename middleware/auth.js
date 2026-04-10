import jwt from 'jsonwebtoken';
import { supabase } from '../config/supabase.js';

export const protect = async (req, res, next) => {
  try {
    let token;

    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
      token = req.headers.authorization.split(' ')[1];
    }

    if (!token) {
      return res.status(401).json({ success: false, message: 'غير مصرح بالدخول' });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    const { data, error } = await supabase
      .from('users')
      .select('id, name, phone, email, role')
      .eq('id', decoded.id)
      .single();

    if (error || !data) {
      return res.status(401).json({ success: false, message: 'المستخدم غير موجود' });
    }

    req.user = data;
    next();
  } catch (error) {
    return res.status(401).json({ success: false, message: 'غير مصرح بالدخول' });
  }
};

export const adminOnly = (req, res, next) => {
  if (req.user && req.user.role === 'admin') {
    next();
  } else {
    res.status(403).json({ success: false, message: 'هذه الصفحة للمسؤولين فقط' });
  }
};
