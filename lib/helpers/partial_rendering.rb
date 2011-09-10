module PartialRendering
  def partial(name, params)
    haml name, :layout => false, :locals => params
  end
end