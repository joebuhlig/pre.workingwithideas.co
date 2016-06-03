require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 0,
      'html' => '$12',
      'class' => 'zero'
    },
    {
      'count' => 1,
      'html' => '$15',
      'class' => 'one'
    },
    {
      'count' => 2,
      'html' => '$18',
      'class' => 'two'
    },
    {
      'count' => 3,
      'html' => '$21',
      'class' => 'three'
    },
    {
      'count' => 4,
      'html' => '$24',
      'class' => 'four'
    },
    {
      'count' => 5,
      'html' => '$27',
      'class' => 'five guideline'
    },
    {
      'count' => 6,
      'html' => '$30',
      'class' => 'six'
    },
    {
      'count' => 7,
      'html' => '$33',
      'class' => 'seven'
    },
    {
      'count' => 8,
      'html' => '$36',
      'class' => 'eight'
    },
    {
      'count' => 9,
      'html' => '$39',
      'class' => 'nine'
    },
    {
      'count' => 10,
      'html' => '$42',
      'class' => 'ten guideline'
    },
    {
      'count' => 11,
      'html' => '$45',
      'class' => 'eleven'
    },
    {
      'count' => 12,
      'html' => '$48',
      'class' => 'twelve'
    },
    {
      'count' => 13,
      'html' => '$51',
      'class' => 'thirteen'
    },
    {
      'count' => 14,
      'html' => '$54',
      'class' => 'fourteen'
    },
    {
      'count' => 15,
      'html' => '$57',
      'class' => 'fifteen guideline'
    },
    {
      'count' => 16,
      'html' => '$60',
      'class' => 'sixteen'
    },
    {
      'count' => 17,
      'html' => '$63',
      'class' => 'seventeen'
    },
    {
      'count' => 18,
      'html' => '$66',
      'class' => 'eighteen'
    },
    {
      'count' => 19,
      'html' => '$69',
      'class' => 'nineteen'
    },
    {
      'count' => 20,
      'html' => 'FREE!',
      'class' => 'twenty guideline'
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self).deliver_now
  end
end
