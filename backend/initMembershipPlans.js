const mongoose = require('mongoose');
const MembershipPlan = require('./models/MembershipPlan');
require('dotenv').config();

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI || 'mongodb://localhost:27017/test')
  .then(() => {
    console.log('Connected to MongoDB');
    initializePlans();
  })
  .catch((error) => {
    console.error('Failed to connect to MongoDB:', error);
  });

async function initializePlans() {
  try {
    // Check if plans already exist
    const existingPlans = await MembershipPlan.find();
    if (existingPlans.length > 0) {
      console.log('Membership plans already exist. Skipping initialization.');
      mongoose.disconnect();
      return;
    }

    // Create default membership plans
    const plans = [
      {
        name: '首周体验',
        price: 9.9,
        duration: 7,
        durationUnit: 'day',
        isFirstTimeOnly: true,
        description: '首次购买专享，到期自动续费',
      },
      {
        name: '月度会员',
        price: 29.9,
        duration: 30,
        durationUnit: 'day',
        isFirstTimeOnly: false,
        description: '按月订阅',
      },
      {
        name: '季度会员',
        price: 79.9,
        duration: 90,
        durationUnit: 'day',
        isFirstTimeOnly: false,
        description: '按季订阅',
      },
      {
        name: '年度会员',
        price: 299.9,
        duration: 365,
        durationUnit: 'day',
        isFirstTimeOnly: false,
        description: '按年订阅',
      },
    ];

    // Insert plans
    const insertedPlans = await MembershipPlan.insertMany(plans);
    console.log(`Successfully created ${insertedPlans.length} membership plans`);
    console.log('Plans:', insertedPlans);

    mongoose.disconnect();
  } catch (error) {
    console.error('Error initializing membership plans:', error);
    mongoose.disconnect();
  }
}
