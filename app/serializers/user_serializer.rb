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

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :first_name, :last_name, :email
end
