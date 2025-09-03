const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true, lowercase: true },
  passwordHash: { type: String }, // null for Google-only users
  name: { type: String },
  googleId: { type: String }, // populate when using Google
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', userSchema);
