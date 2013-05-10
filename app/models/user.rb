class User < ActiveRecord::Base
  has_secure_password
  #If someone clicks 'Sign Up' on the home page,
  #They should be asked for their email and their class code
  #And entering those should prompt the user to choose a password
  attr_accessible :email, :name, :password, :password_confirmation, :classcode, :active
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false, allow_nil: true
  # validates_format_of :password, with: /((?=.*\d)(?=.*[A-Z]).{8,})/, message: 'must contain at least 1 number and 1 capital letter and be at least 8 characters long', allow_nil: true, on: :standard, if: :password?
  has_many :comments
  has_many :assignments
  has_many :scores
  ROLES = %w(user admin teacher)

  def after_initialize!
    #generate random password
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    self.password  =  (0...50).map{ o[rand(o.length)] }.join
    self.password_confirmation = password
      #Temp password to satisfy necessary password digest
      #Replaced by sessions controller if logging in and user.active == false
    #generate auth token
    p =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    self.email_activation_token  =  (0...50).map{ p[rand(p.length)] }.join
    #mail auth token link
    #set expiration date
    self.confirmable_set_at = Time.now
    self.save
    UserMailer.welcome_email(self).deliver
  end

  def role
    @role_inquirer ||= ActiveSupport::StringInquirer.new(self[:role])
  end

  def role= role
    remove_instance_variable :@role_inquirer if defined?(@role_inquirer)
    super
  end

  def password?
    password.present?
  end

  def teacher?
    self.role == "teacher"
  end

  def admin?
    self.role == "admin"
  end

  def activate!
    #moved self.active = true to sessions controller, letting it set a password first
    self.email_activation_token = nil
    self.save
  end
end
