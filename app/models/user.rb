#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  attr_accessor :login
  # for client side validations
  validates :username, :password, presence: true
  validates_format_of :username, :with => /\A[a-z]+[0-9]*\z/i, :allow_blank => true, :message => "Your ID should contain letters and numbers only."
  validates_length_of :password, :minimum => 8, :allow_blank => true

  # refer to the smaple at: https://github.com/RailsApps/rails-devise-roles
  enum role: {user: 100, bronze: 1, silver: 2, gold: 3, platinum: 4, admin: 0, \
                go: 6, hr: 7, risk: 8, compliance: 9, management: 11, pb: 12, ib: 13, \
                tre: 14, sbd: 15, tb: 16, ops: 17, it: 18, fa: 19 }
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value ", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def ldap_before_save
    #
    dptm = Devise::LDAP::Adapter.get_ldap_param(self.username,"department").first
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
    self.department = dptm
    # Assign user role based on user department
    case  dptm
    when "Human Resources"
      self.role = :hr
    when "General Office"
      self.role = :go
    when "Risk Management"
      self.role = :risk
    when "IT"
      self.role = :gold
    when "Management"
      self.role = :platinum
    when "Compliance"
      self.role = :compliance
    when "PB"
      self.role = :pb
    when "Treasury"
      self.role = :tre
    when "SPD"
      self.role = :sbd
    when "TransactionBanking"
      self.role = :tb
    when "Banking Operations"
      self.role = :ops
    when "Finance"
      self.role = :fa
    else
      self.role = :user
    end
    Rails.logger.debug ("Assign user role to #{self.username}: #{self.role}")
    # Added by Yang 02/11/2016
    self.dn = Devise::LDAP::Adapter.get_dn(self.username)
  end

  scope :department, -> (department) { where department: department}

end
