module StaticMapHelper

  def static_map_for(micropost, options = {})
    params = {
      :center => [micropost.latitude, micropost.longitude].join(","),
      :zoom => 15,
      :size => "536x250",
      :markers => [micropost.latitude, micropost.longitude].join(","),
      :sensor => true,
      :key => "AIzaSyDQXwmd-eVvllriFGJR2h6VBmpZmEvpEj8"
      }.merge(options)

    query_string =  params.map{|k,v| "#{k}=#{v}"}.join("&")
    image_tag "http://maps.googleapis.com/maps/api/staticmap?#{query_string}", :alt => micropost.full_street_address
  end

end
