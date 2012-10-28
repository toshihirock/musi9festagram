require "sinatra"
require "instagram"

#util
TAG_NAME = 0

#detail
DETAIL_MEDIA_ID = 1
NEXT_MAX_ID = 2

# feed
NEXT_USE_TAG_ID = 1
FIRST_PAGE = "-1"

Instagram.configure do |config|
  config.client_id = "4385c1efac054540ab04a36ccadd4ea1"
  config.client_secret = "b5e384bd770248a7a2c885b93013d513"
  config.access_token = "3739387.4385c1e.d6e9a109a1744466a79388393faeb691"
end

get "/" do
  erb :index
end

get "/detail/*/*/*"do
  @tag_name = params[:splat][TAG_NAME]
  @detail = Instagram.media_item(params[:splat][DETAIL_MEDIA_ID])
  @next_max_id = params[:splat][NEXT_MAX_ID]
  erb :detail
end

get "/thumbnail/*/*" do
 
  if params[:splat][NEXT_USE_TAG_ID] == FIRST_PAGE then
    media_item = Instagram.tag_recent_media(params[:splat][TAG_NAME])
  else
    option ={"max_tag_id" => params[:splat][NEXT_USE_TAG_ID]}
    media_item = Instagram.tag_recent_media(params[:splat][TAG_NAME],option)
  end
    
  @tag_name = params[:splat][TAG_NAME]
  @current_max_id = params[:splat][NEXT_USE_TAG_ID]
  @next_max_id = media_item.pagination.next_max_id
  @data = media_item['data']
  erb :thumbnail
end
