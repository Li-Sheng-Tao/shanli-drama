const express = require('express');
const router = express.Router();
const User = require('../models/User');
const PaymentRecord = require('../models/PaymentRecord');
const Content = require('../models/Content');
const { verifyToken, verifyAdmin } = require('../middleware/auth');

// User growth analysis
router.get('/user-growth', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { days = 30 } = req.query;
    
    // Calculate date range
    const endDate = new Date();
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - Number(days));
    
    // Group users by registration date
    const userGrowth = await User.aggregate([
      {
        $match: {
          createdAt: {
            $gte: startDate,
            $lte: endDate
          }
        }
      },
      {
        $group: {
          _id: {
            $dateToString: {
              format: '%Y-%m-%d',
              date: '$createdAt'
            }
          },
          count: { $sum: 1 }
        }
      },
      {
        $sort: { _id: 1 }
      }
    ]);
    
    res.json(userGrowth);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Membership purchase analysis
router.get('/membership-purchases', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { days = 30 } = req.query;
    
    // Calculate date range
    const endDate = new Date();
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - Number(days));
    
    // Group payments by date and plan
    const purchases = await PaymentRecord.aggregate([
      {
        $match: {
          status: 'success',
          createdAt: {
            $gte: startDate,
            $lte: endDate
          }
        }
      },
      {
        $group: {
          _id: {
            date: {
              $dateToString: {
                format: '%Y-%m-%d',
                date: '$createdAt'
              }
            },
            planId: '$planId'
          },
          count: { $sum: 1 },
          amount: { $sum: '$amount' }
        }
      },
      {
        $lookup: {
          from: 'membershipplans',
          localField: '_id.planId',
          foreignField: '_id',
          as: 'plan'
        }
      },
      {
        $unwind: '$plan'
      },
      {
        $sort: { '_id.date': 1 }
      }
    ]);
    
    res.json(purchases);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Revenue analysis
router.get('/revenue', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const { days = 30, groupBy = 'day' } = req.query;
    
    // Calculate date range
    const endDate = new Date();
    const startDate = new Date();
    startDate.setDate(startDate.getDate() - Number(days));
    
    // Group by format based on groupBy parameter
    let dateFormat = '%Y-%m-%d';
    if (groupBy === 'month') {
      dateFormat = '%Y-%m';
    } else if (groupBy === 'year') {
      dateFormat = '%Y';
    }
    
    // Calculate revenue
    const revenue = await PaymentRecord.aggregate([
      {
        $match: {
          status: 'success',
          createdAt: {
            $gte: startDate,
            $lte: endDate
          }
        }
      },
      {
        $group: {
          _id: {
            $dateToString: {
              format: dateFormat,
              date: '$createdAt'
            }
          },
          revenue: { $sum: '$amount' },
          transactions: { $sum: 1 }
        }
      },
      {
        $sort: { _id: 1 }
      }
    ]);
    
    res.json(revenue);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Content popularity analysis
router.get('/content-popularity', verifyToken, verifyAdmin, async (req, res) => {
  try {
    // This would typically use a view counter, but for now we'll use creation date and published status
    const popularContent = await Content.find({ isPublished: true })
      .sort({ createdAt: -1 })
      .limit(10)
      .select('title category tags createdAt isPublished');
    
    res.json(popularContent);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// User demographics analysis
router.get('/user-demographics', verifyToken, verifyAdmin, async (req, res) => {
  try {
    // Calculate user stats
    const totalUsers = await User.countDocuments();
    const vipUsers = await User.countDocuments({ isVip: true });
    const nonVipUsers = totalUsers - vipUsers;
    
    // Calculate user growth rate
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    const usersInLast30Days = await User.countDocuments({ createdAt: { $gte: thirtyDaysAgo } });
    
    // Calculate VIP conversion rate
    const vipConversionRate = totalUsers > 0 ? (vipUsers / totalUsers) * 100 : 0;
    
    res.json({
      totalUsers,
      vipUsers,
      nonVipUsers,
      usersInLast30Days,
      vipConversionRate: vipConversionRate.toFixed(2)
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Payment method analysis
router.get('/payment-methods', verifyToken, verifyAdmin, async (req, res) => {
  try {
    const paymentMethods = await PaymentRecord.aggregate([
      {
        $match: {
          status: 'success'
        }
      },
      {
        $group: {
          _id: '$paymentMethod',
          count: { $sum: 1 },
          amount: { $sum: '$amount' }
        }
      },
      {
        $sort: { count: -1 }
      }
    ]);
    
    res.json(paymentMethods);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;