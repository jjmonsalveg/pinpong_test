# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string           not null
#  last_name       :string           not null
#  email           :string(320)      not null
#  password_digest :string(60)       not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  score           :float            default(0.0), not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  # -- Constants ------------------------------------------------------------

  # -- Attributes -----------------------------------------------------------

  # -- AR Extensions --------------------------------------------------------

  has_secure_password

  # -- Relationships --------------------------------------------------------

  # -- Validations ----------------------------------------------------------

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :score, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }

  # -- Scopes ---------------------------------------------------------------
  scope :leadboard, -> { select('*, RANK() OVER(ORDER BY score DESC) AS ranking') }
  # -- Callbacks ------------------------------------------------------------

  # -- Class Methods --------------------------------------------------------

  # -- Instance Methods -----------------------------------------------------

  def full_name
    "#{first_name} #{last_name}"
  end

  def rank
    @rank ||= self.class.games? ?  self.class.leadboard.to_a.index(self) + 1 : 0
  end

  def self.games?
    Game.any? && User.where('score > 0').any?
  end

  def self.lead
    self.games? ? all.order(score: :desc).first : nil
  end
end
