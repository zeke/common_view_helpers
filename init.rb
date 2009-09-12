require File.dirname(__FILE__) + '/lib/common_view_helpers'

ActionView::Base.send( :include, CommonViewHelpers::ViewHelpers )