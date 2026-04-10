import bcrypt from 'bcryptjs';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config();

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

async function createAdmin() {
  try {
    const password = 'admin123';
    const hashedPassword = await bcrypt.hash(password, 10);

    // Check if admin exists
    const { data: existingAdmin } = await supabase
      .from('users')
      .select('*')
      .eq('phone', '0500000000')
      .single();

    let result;
    if (existingAdmin) {
      // Update existing admin
      const { data, error } = await supabase
        .from('users')
        .update({
          password: hashedPassword,
          role: 'admin'
        })
        .eq('phone', '0500000000')
        .select('id, name, phone, email, role')
        .single();

      if (error) throw error;
      result = data;
      console.log('✅ Admin user updated successfully:');
    } else {
      // Create new admin
      const { data, error } = await supabase
        .from('users')
        .insert([{
          name: 'Admin',
          phone: '0500000000',
          email: 'admin@fruvelle.com',
          password: hashedPassword,
          role: 'admin'
        }])
        .select('id, name, phone, email, role')
        .single();

      if (error) throw error;
      result = data;
      console.log('✅ Admin user created successfully:');
    }

    console.log(result);
    console.log('\nLogin credentials:');
    console.log('Phone: 0500000000');
    console.log('Password: admin123');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error creating admin:', error);
    process.exit(1);
  }
}

createAdmin();
