module Pagination
  def link_with_pagination(url, page_number=params[:service_page])
    url + "?service_page=#{page_number}"
  end
end