class History < ApplicationRecord
  belongs_to :user
  def self.get_where_clause(time_period)
  	if 'Last hour' == time_period
  		return 'created_at BETWEEN ? AND  ?',Time.now - 1.hours , Time.now
  	elsif 'Last 24 Hours' == time_period
  		return 'created_at BETWEEN ? AND  ?',Time.now - 1.days , Time.now
  	elsif 'Last 7 days' == time_period
  		return 'created_at BETWEEN ? AND  ?',Time.now - 7.days , Time.now
  	elsif 'Last 4 weeks' == time_period
  		return 'created_at BETWEEN ? AND  ?',Time.now - 28.days , Time.now
  	elsif 'All time' == time_period
  		return ''
  	end
  end
end
