module Pagination

  def current_page
    (params[:service_page] || 1).to_i
  end

  def link_with_pagination(url)
    url + "?service_page=#{current_page}"
  end
end