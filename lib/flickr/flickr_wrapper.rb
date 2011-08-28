require "flickraw"

class FlickWrapper

  def initialize(options)
    FlickRaw.api_key = options["key"]
    FlickRaw.shared_secret = options["secret"]
  end

  def search(options)
    raise "Options 'tag' and 'group' are mandatory" unless options.key?(:tag) && options.key?(:group)

    default_options = { :extras => "url_sq", :per_page => 20, :license => "1,2,4,5,7" }
    group_id = group_id_from options[:group]

    return flickr.photos.search({ :group_id => group_id, :tags => options[:tag] }.merge(default_options))
  end

  private

  def group_id_from(group) 
    flickr.groups.search(:text => group).find { |g| g.name == group }.nsid
  end

end