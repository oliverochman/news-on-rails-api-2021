Stripe.plan :nor_subscription_plan do |plan| 
  plan.name = 'News on Rails Subscription'
  plan.amount = 15000
  plan.currency = 'usd'
  plan.interval = 'month'
  plan.interval_count = 12
end