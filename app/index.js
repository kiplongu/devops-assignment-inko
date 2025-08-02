const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;
const mongoURI = process.env.MONGO_URI || 'mongodb://mongo:27017/devopsdb';

// MongoDB connection
mongoose
  .connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log('✅ Connected to MongoDB'))
  .catch((err) => console.error('❌ MongoDB connection error:', err));

// Root route
app.get('/', (req, res) => {
  res.send('Welcome to the DevOps Assignment by Rodgers Biwott for Inkomoko — powered by Node.js and MongoDB.');
});

// Optional: Health check endpoint
app.get('/health', async (req, res) => {
  try {
    await mongoose.connection.db.admin().ping();
    res.status(200).json({ status: 'UP', database: 'MongoDB reachable' });
  } catch (err) {
    res.status(500).json({ status: 'DOWN', error: err.message });
  }
});

app.listen(port, () => {
  console.log(`🚀 App listening on port ${port}`);
});
