require 'test_helper'

class ArmyTest < ActiveSupport::TestCase
  has_valid_factory

  responds_to :id
  responds_to :name
  responds_to :faction
  responds_to :force_size

  validates_presence_of :name
  validates_presence_of :faction
  validates_presence_of :force_size
end
