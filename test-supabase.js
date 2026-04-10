import { supabase } from './config/supabase.js';

async function testSupabase() {
  try {
    console.log('Testing Supabase connection...');
    
    // Test products query
    const { data, error } = await supabase
      .from('products')
      .select('*')
      .limit(5);
    
    if (error) {
      console.error('❌ Error:', error);
      process.exit(1);
    }
    
    console.log('✅ Connection successful!');
    console.log(`📦 Found ${data.length} products:`);
    data.forEach(p => console.log(`  - ${p.name_ar} (${p.price} ريال)`));
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Failed:', error.message);
    process.exit(1);
  }
}

testSupabase();
