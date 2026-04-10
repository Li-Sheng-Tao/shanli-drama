const express = require('express');
const router = express.Router();
const Content = require('../models/Content');
const { verifyToken, verifyAdmin } = require('../middleware/auth');

// Get all published content (public)
router.get('/', async (req, res) => {
  try {
    const content = await Content.find({ isPublished: true });
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Get content by ID (public)
router.get('/:id', async (req, res) => {
  try {
    const content = await Content.findById(req.params.id);
    if (!content) {
      return res.status(404).json({ message: 'Content not found' });
    }
    
    // Only show published content to non-admins
    if (!content.isPublished && !req.user?.isAdmin) {
      return res.status(404).json({ message: 'Content not found' });
    }
    
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Get all content (admin only)
router.get('/admin/all', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const content = await Content.find();
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Create new content (admin only)
router.post('/', verifyToken, verifyAdmin, async (req, res) => {
  const content = new Content({
    title: req.body.title,
    description: req.body.description,
    coverImage: req.body.coverImage,
    contentUrl: req.body.contentUrl,
    category: req.body.category,
    tags: req.body.tags,
    isPublished: req.body.isPublished || false,
  });

  try {
    const newContent = await content.save();
    res.status(201).json(newContent);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Update content (admin only)
router.put('/:id', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const content = await Content.findById(req.params.id);
    if (!content) {
      return res.status(404).json({ message: 'Content not found' });
    }

    content.title = req.body.title || content.title;
    content.description = req.body.description || content.description;
    content.coverImage = req.body.coverImage || content.coverImage;
    content.contentUrl = req.body.contentUrl || content.contentUrl;
    content.category = req.body.category || content.category;
    content.tags = req.body.tags || content.tags;
    content.isPublished = req.body.isPublished !== undefined ? req.body.isPublished : content.isPublished;

    const updatedContent = await content.save();
    res.json(updatedContent);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Delete content (admin only)
router.delete('/:id', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const content = await Content.findById(req.params.id);
    if (!content) {
      return res.status(404).json({ message: 'Content not found' });
    }

    await content.deleteOne();
    res.json({ message: 'Content deleted' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Search content by title or tags (public)
router.get('/search', async (req, res) => {
  try {
    const { query } = req.query;
    if (!query) {
      return res.status(400).json({ message: 'Search query is required' });
    }

    const content = await Content.find({
      isPublished: true,
      $or: [
        { title: { $regex: query, $options: 'i' } },
        { tags: { $regex: query, $options: 'i' } },
        { category: { $regex: query, $options: 'i' } },
      ],
    });

    res.json(content);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Get content by category (public)
router.get('/category/:category', async (req, res) => {
  try {
    const { category } = req.params;
    const content = await Content.find({ 
      isPublished: true, 
      category: { $regex: category, $options: 'i' } 
    });
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;