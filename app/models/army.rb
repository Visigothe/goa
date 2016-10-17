class Army < ApplicationRecord
  # ARMY_FACTIONS =  %w(concord ghar algoryn isorian boromite freeborn ghar_outcast)
  ARMY_FACTIONS =  %w(algoryn)
  FORCE_SIZES = %w(scouting_force skirmish_force combat_force battle_force offensive_force invasion_force conquest_force)

  validates_presence_of :name
  validates_presence_of :faction
  validates_presence_of :force_size
  # TODO: Add more validations

  def self.army_factions_for_select
    default_option = ['Choose a Faction', nil]
    select_options = [default_option]
    ARMY_FACTIONS.each do |faction|
      label = faction.gsub('_',' ').titleize
      select_options << [label, faction]
    end
    select_options
  end

  def self.force_sizes_for_select
    default_option = ['Choose a Force Size', nil]
    select_options = [default_option]
    FORCE_SIZES.each do |size|
      label = size.gsub('_',' ').titleize
      select_options << [label, size]
    end
    select_options
  end
end
