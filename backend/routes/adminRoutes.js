const express = require('express');
const router = express.Router();
const User = require('../models/User');
const PaymentRecord = require('../models/PaymentRecord');
const Content = require('../models/Content');
const { verifyToken, verifyAdmin } = require('../middleware/auth');

// Admin dashboard stats
router.get('/dashboard/stats', verifyToken, verifyAdmin, async (req, res) => {
  try {
    // Total users
    const totalUsers = await User.countDocuments();
    
    // Total VIP users
    const totalVipUsers = await User.countDocuments({ isVip: true });
    
    // Total content
    const totalContent = await Content.countDocuments();
    
    // Total published content
    const totalPublishedContent = await Content.countDocuments({ isPublished: true });
    
    // Total payments
    const totalPayments = await PaymentRecord.countDocuments({ status: 'success' });
    
    // Total revenue
    const totalRevenue = await PaymentRecord.aggregate([
      { $match: { status: 'success' } },
      { $group: { _id: null, total: { $sum: '$amount' } } }
    ]);
    
    res.json({
      totalUsers,
      totalVipUsers,
      totalContent,
      totalPublishedContent,
      totalPayments,
      totalRevenue: totalRevenue.length > 0 ? totalRevenue[0].total : 0
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Get users with filters
router.get('/users', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { page = 1, limit = 10, search, isVip, isAdmin } = req.query;
    
    const filter = {};
    
    if (search) {
      filter.$or = [
        { name: { $regex: search, $options: 'i' } },
        { email: { $regex: search, $options: 'i' } }
      ];
    }
    
    if (isVip !== undefined) {
      filter.isVip = isVip === 'true';
    }
    
    if (isAdmin !== undefined) {
      filter.isAdmin = isAdmin === 'true';
    }
    
    const total = await User.countDocuments(filter);
    const users = await User.find(filter)
      .skip((page - 1) * limit)
      .limit(Number(limit))
      .sort({ createdAt: -1 });
    
    res.json({
      users,
      pagination: {
        total,
        page: Number(page),
        limit: Number(limit),
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Batch update users
router.post('/users/batch-update', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { userIds, updates } = req.body;
    
    if (!userIds || !Array.isArray(userIds)) {
      return res.status(400).json({ message: 'User IDs array is required' });
    }
    
    if (!updates) {
      return res.status(400).json({ message: 'Updates object is required' });
    }
    
    const result = await User.updateMany(
      { _id: { $in: userIds } },
      { $set: updates }
    );
    
    res.json({ message: `${result.modifiedCount} users updated`, result });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Batch delete users
router.post('/users/batch-delete', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { userIds } = req.body;
    
    if (!userIds || !Array.isArray(userIds)) {
      return res.status(400).json({ message: 'User IDs array is required' });
    }
    
    // Prevent deleting admin users
    const adminUsers = await User.find({ _id: { $in: userIds }, isAdmin: true });
    if (adminUsers.length > 0) {
      return res.status(400).json({ message: 'Cannot delete admin users' });
    }
    
    const result = await User.deleteMany({ _id: { $in: userIds } });
    
    res.json({ message: `${result.deletedCount} users deleted`, result });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Get user payment history
router.get('/users/:userId/payments', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { userId } = req.params;
    
    const payments = await PaymentRecord.find({ userId })
      .populate('planId')
      .sort({ createdAt: -1 });
    
    res.json(payments);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Update user membership status
router.put('/users/:userId/membership', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { userId } = req.params;
    const { isVip, vipExpireDate, vipPlan, autoRenew } = req.body;
    
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    
    if (isVip !== undefined) {
      user.isVip = isVip;
    }
    
    if (vipExpireDate) {
      user.vipExpireDate = new Date(vipExpireDate);
    }
    
    if (vipPlan) {
      user.vipPlan = vipPlan;
    }
    
    if (autoRenew !== undefined) {
      user.autoRenew = autoRenew;
    }
    
    const updatedUser = await user.save();
    res.json(updatedUser);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;