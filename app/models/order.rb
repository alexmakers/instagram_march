class Order < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  after_create :send_confirmation_email

  def number
    date_section = created_at.strftime('%d%m%y')
    id_section = "%04d" % id

    date_section + id_section
  end

  def send_confirmation_email
    OrderMailer.successful_order(self).deliver!
  end

end
