import pool from './config/database.js';

async function testConnection() {
  try {
    console.log('Testing database connection...');
    console.log('Host:', process.env.DB_HOST);
    console.log('Port:', process.env.DB_PORT);
    console.log('Database:', process.env.DB_NAME);
    console.log('User:', process.env.DB_USER);
    console.log('Password:', process.env.DB_PASSWORD ? '***' : 'NOT SET');
    
    const result = await pool.query('SELECT NOW()');
    console.log('✅ Connection successful!');
    console.log('Server time:', result.rows[0].now);
    
    const tables = await pool.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
    `);
    console.log('\n📋 Tables in database:');
    tables.rows.forEach(row => console.log('  -', row.table_name));
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Connection failed:', error.message);
    console.error('Full error:', error);
    process.exit(1);
  }
}

testConnection();
