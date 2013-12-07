class Credential < Neo4j::Rails::Model
  attr_accessible :email, :password, :password_confirmation
  #has_secure_password

  property :email, :type => String, :index => :fulltext, unique: true
  property :password_digest, :type => String
  
  property :updated_at
  property :created_at

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false }
  validates :password,  presence: true,
                        length: { minimum: 6 }

  has_one(:user).to(User)

  before_save { self.email = email.downcase }

end
