const mongoose = require('mongoose');

const contentSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    default: '',
  },
  coverImage: {
    type: String,
    default: '',
  },
  contentUrl: {
    type: String,
    default: '',
  },
  category: {
    type: String,
    default: '',
  },
  tags: {
    type: [String],
    default: [],
  },
  isPublished: {
    type: Boolean,
    default: false,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
});

// Update updatedAt field before saving
contentSchema.pre('save', function(next) {
  this.updatedAt = new Date();
  next();
});

const Content = mongoose.model('Content', contentSchema);

module.exports = Content;