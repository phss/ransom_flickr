module Pagination

  def current_page
    (params[:service_page] || 1).to_i
  end

  def link_with_pagination(url, page_number=current_page)
    url + "?service_page=#{page_number}"
  end

  def render_pagination(base_url)
    haml :pagination, :layout => false, :locals => { :base_url => base_url }
  end
end