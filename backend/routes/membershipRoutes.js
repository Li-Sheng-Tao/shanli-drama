const express = require('express');
const router = express.Router();
const User = require('../models/User');
const MembershipPlan = require('../models/MembershipPlan');
const PaymentRecord = require('../models/PaymentRecord');
const { verifyToken, verifyAdmin } = require('../middleware/auth');

// Get all membership plans
router.get('/plans', async (req, res) => {
  try {
    const plans = await MembershipPlan.find();
    res.json(plans);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Create a membership plan (admin)
router.post('/plans', verifyToken, verifyAdmin, async (req, res) => {
  const plan = new MembershipPlan({
    name: req.body.name,
    price: req.body.price,
    duration: req.body.duration,
    durationUnit: req.body.durationUnit,
    isFirstTimeOnly: req.body.isFirstTimeOnly,
    description: req.body.description,
  });

  try {
    const newPlan = await plan.save();
    res.status(201).json(newPlan);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Get user membership status
router.get('/status/:userId', verifyToken, async (req, res) => {
  try {
    // Check if user is admin or trying to access own status
    if (!req.user.isAdmin && req.user.id !== req.params.userId) {
      return res.status(403).json({ message: 'Access denied' });
    }

    const user = await User.findById(req.params.userId).populate('vipPlan');
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const status = {
      isVip: user.isVip,
      vipExpireDate: user.vipExpireDate,
      vipPlan: user.vipPlan,
      autoRenew: user.autoRenew,
    };

    res.json(status);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Purchase membership
router.post('/purchase', verifyToken, async (req, res) => {
  try {
    const { userId, planId, autoRenew } = req.body;

    // Check if user is admin or trying to purchase for themselves
    if (!req.user.isAdmin && req.user.id !== userId) {
      return res.status(403).json({ message: 'Access denied' });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const plan = await MembershipPlan.findById(planId);
    if (!plan) {
      return res.status(404).json({ message: 'Plan not found' });
    }

    // Check if it's a first-time only plan and user has already purchased
    if (plan.isFirstTimeOnly) {
      const existingPayment = await PaymentRecord.findOne({ userId, planId, status: 'success' });
      if (existingPayment) {
        return res.status(400).json({ message: 'This plan is only available for first-time purchase' });
      }
    }

    // Create payment record
    const payment = new PaymentRecord({
      userId,
      planId,
      amount: plan.price,
      status: 'pending',
    });

    // Simulate payment success (in real app, integrate with payment gateway)
    payment.status = 'success';
    payment.transactionId = `TXN_${Date.now()}`;
    await payment.save();

    // Calculate expire date
    let expireDate = new Date();
    switch (plan.durationUnit) {
      case 'day':
        expireDate.setDate(expireDate.getDate() + plan.duration);
        break;
      case 'month':
        expireDate.setMonth(expireDate.getMonth() + plan.duration);
        break;
      case 'year':
        expireDate.setFullYear(expireDate.getFullYear() + plan.duration);
        break;
    }

    // Update user membership status
    user.isVip = true;
    user.vipExpireDate = expireDate;
    user.vipPlan = planId;
    user.autoRenew = autoRenew || false;
    await user.save();

    res.json({ 
      message: 'Membership purchased successfully',
      user,
      payment,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Cancel auto-renew
router.post('/cancel-renew', verifyToken, async (req, res) => {
  try {
    const { userId } = req.body;

    // Check if user is admin or trying to cancel their own auto-renew
    if (!req.user.isAdmin && req.user.id !== userId) {
      return res.status(403).json({ message: 'Access denied' });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    user.autoRenew = false;
    await user.save();

    res.json({ message: 'Auto-renew cancelled successfully', user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Payment webhook (for real payment gateway integration)
router.post('/webhook', async (req, res) => {
  try {
    // In real app, verify the webhook signature
    // Then process the payment status
    const { transactionId, status, userId, planId } = req.body;

    const payment = await PaymentRecord.findOne({ transactionId });
    if (payment) {
      payment.status = status;
      await payment.save();

      if (status === 'success') {
        // Update user membership status
        const user = await User.findById(userId);
        const plan = await MembershipPlan.findById(planId);

        let expireDate = new Date();
        switch (plan.durationUnit) {
          case 'day':
            expireDate.setDate(expireDate.getDate() + plan.duration);
            break;
          case 'month':
            expireDate.setMonth(expireDate.getMonth() + plan.duration);
            break;
          case 'year':
            expireDate.setFullYear(expireDate.getFullYear() + plan.duration);
            break;
        }

        user.isVip = true;
        user.vipExpireDate = expireDate;
        user.vipPlan = planId;
        await user.save();
      }
    }

    res.json({ message: 'Webhook processed successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;