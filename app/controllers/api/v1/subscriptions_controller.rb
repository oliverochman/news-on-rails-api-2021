class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    begin
    customer_id = get_customer(params[:stripeToken])

    subscription = Stripe::Subscription.create({
       customer: customer_id,
       plan: 'nor_subscription_plan'
      })
      
      test_env?(customer_id, subscription)


      status = Stripe::Invoice.retrieve(subscription.latest_invoice).paid

      if status 
        current_user.update_attribute(:role, 'subscriber')
        render json: {message: 'Transaction was successfull'}

      else
        render_stripe_error('Transaction was unsuccessfull')

      end

    rescue => error
      render_stripe_error(error.message)

    end 
  end

  private 

  def get_customer(stripeToken)
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create({email: current_user.email, source: stripeToken })

    customer.id
  end

  def render_stripe_error(error)
    render json: {message: "Something went wrong. #{error}"}, status: 422
  end

  def test_env?(customer, subscription)
    if Rails.env.test?
      invoice = Stripe::Invoice.create({ customer: customer, subscription: subscription.id, paid: true})
      subscription.latest_invoice = invoice.id
    end
  end
end
