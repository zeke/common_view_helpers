require 'rubygems'
require 'RedCloth'
require 'active_support' # to get methods like blank? and starts_with?
require 'action_view'  
require File.dirname(__FILE__) + '/../lib/common_view_helpers'

include ActionView::Helpers
include CommonViewHelpers::ViewHelpers
# include ActionView::Helpers::TextHelper
# include ActionView::Helpers::TagHelper
# include ActionView::Helpers::DateHelper
# include ActionView::Helpers::CacheHelper
# include ActionView::Helpers::CaptureHelper # For the generate_table method

describe CommonViewHelpers do
  context "time_ago_in_words_or_date" do
    it "gets relative times right" do
      time_ago_in_words_or_date(Time.now - 10.minutes).should == "10 minutes ago"
      time_ago_in_words_or_date(Time.now - 1.day).should == "1 day ago"
      time_ago_in_words_or_date(Time.now - 2.days).should == "2 days ago"
    end
    
    it "should use short format for non-relative dates in the last year" do
      time_ago_in_words_or_date(Time.now - 8.days).should =~ /\w{3} \d+/i
      time_ago_in_words_or_date(Time.now - 6.months).should =~ /\w{3} \d+/i
    end
    
    it "should display year format for non-relative dates beyond one year ago" do
      time_ago_in_words_or_date(Time.now - 13.months).should =~ /\w{3} \d+, \d{4}/i
    end
  end
  
  context "generate_table" do
    it "should generate a simple table" do
      collection = [%w(lucy 12)]
      headers = %w(name age)
      # generate_table(collection, headers).should == "<table><thead><tr><th>name</th><th>age</th></tr></thead><tbody><tr><td>lucy</td><td>12</td></tr></tbody></table>"
    end
    
  end
  
end