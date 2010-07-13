class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer, :position
  validates_numericality_of :position
  acts_as_taggable
  has_permalink :question
  
  def self.cached_all
    if @production
      Rails.cache.fetch('Faq.cached_all') { find(:all, :order => "position") }
    else
      find(:all, :order => "position")
    end
  end
end
