class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :city
  belongs_to :state
  has_many :products, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates_presence_of :name, :nickname, :cpf, :rg, :address, :birth, :city_id, :password_confirmation, :description
  validates_uniqueness_of :nickname
  validate :password_complexity
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d). /)
      errors.add :password, " Sua senha deve possuir pelo menos uma letra minúscula, uma letra maiúscula e um dígito"
    end
  end

  validates_inclusion_of :birth, :in=>Date.new(1900)..Time.now.years_ago(18).to_date, :message=>'Você deve ter pelo menos 18 anos'

end
