module ApplicationHelper
  
  # Return a logo
  def logo
    logo = image_tag("logo.png", :alt => "Sample Application", :class => "round")
  end
  
  # Return a title on a per-page basis
  def title
    base_title = "Ruby on Rails 3 Tutorial Sample Application"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
       
end
