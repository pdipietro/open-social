class User < Neo4j::Rails::Model

  property :first_name, :type => String
  property :last_name, :type => String
  property :nick_name, :type => String, :index => :exact
  property :email, :type => String, :index => :exact

  property :created_at
  property :updated_at

  property :name, :type => String
  property :password_digest, :type => String
  property :remember_token, :type => String

 # has_secure_password

  validates :first_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true
  validates :nick_name, presence: true, length: {minimum: 2}

  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  has_n(:credentials).from(Credential, :credential)

  class << self
    attr_accessor :min_cost # :nodoc:
  end
  self.min_cost = false

  def formatted_email
    "#{self.first_name} #{self.last_name} (#{self.nick_name}) <#{self.email}>"
  end

  before_save { self.email = email.downcase }
  before_save :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

# ---------------------------------------------------------

#  def has_secure_password(options = {})

       begin
          require 'bcrypt'
        rescue LoadError
          $stderr.puts "You don't have bcrypt-ruby installed in your application. Please add it to your Gemfile and run bundle install"
          raise
        end

        attr_reader :password

#        include InstanceMethodsOnActivation

#        if options.fetch(:validations, true)
          validates_confirmation_of :password, if: :should_confirm_password?
          validates_presence_of :password, on: :create
          validates_presence_of :password_confirmation, if: :should_confirm_password?

          before_create { raise "Password digest missing on new record" if password_digest.blank? }
#        end

        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default #:nodoc:
            super + ['password_digest']
          end
        end

      def authenticate(unencrypted_password)
        BCrypt::Password.new(password_digest) == unencrypted_password && self
      end

      def password=(unencrypted_password)
        unless unencrypted_password.blank?
          @password = unencrypted_password
      #    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
          cost = BCrypt::Engine::MIN_COST
          self.password_digest = BCrypt::Password.create(unencrypted_password, cost: cost)
        end
      end

      def password_confirmation=(unencrypted_password)
        @password_confirmation = unencrypted_password
      end

      private

      def should_confirm_password?
        password_confirmation && password.present?
      end
#  end # def has_secure_password

# --------------------------------------------
=begin
   module InstanceMethodsOnActivation
      def authenticate(unencrypted_password)
        BCrypt::Password.new(password_digest) == unencrypted_password && self
      end

      def password=(unencrypted_password)
        unless unencrypted_password.blank?
          @password = unencrypted_password
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
          self.password_digest = BCrypt::Password.create(unencrypted_password, cost: cost)
        end
      end

      def password_confirmation=(unencrypted_password)
        @password_confirmation = unencrypted_password
      end

      private

      def should_confirm_password?
        password_confirmation && password.present?
      end

    end # module

=end

#def has_secure_password
#end
#has_secure_password 

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
