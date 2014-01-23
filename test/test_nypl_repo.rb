require 'test/unit'
require 'nypl_repo'

##
# Tests for the nypl_repo library
# Note that these currently use the API live
# Pass in the NYPL API Token as an environment variable . ie.
# API_TOKEN=abc123  rake test
#


class NyplRepoTest < Test::Unit::TestCase

  def setup
    @client = NyplRepo::Client.new(ENV["API_TOKEN"], {:debug => ENV["DEBUG"] || false})
  end

  def test_init
    client = NyplRepo::Client.new(ENV["API_TOKEN"])
    assert_not_nil client
  end
  
  def test_get_json
    json_obj = @client.get_json("http://api.repo.nypl.org/api/v1/items/search.json?q=unicorns")
    assert_not_nil json_obj["nyplAPI"]
  end
  
  def test_error
    assert_raise RuntimeError do
      json_obj = @client.get_json("http://api.repo.nypl.org/WRONGapi/v0/items/search.json?q=unicorns")
    end
  end
  
  def test_get_mods_item
    mods_uuid = "510d47e2-8e15-a3d9-e040-e00a18064a99"
    mods_item = @client.get_mods_item(mods_uuid)
    
    assert_equal mods_item["genre"]["$"] , "Planographic prints"
  end
  
  # map id: 7166
  def test_get_mods_uuid
    bibl_uuid = "12deb230-c603-012f-b946-58d385a7bc34"
    image_id = "1268326"
    mods_uuid  = @client.get_mods_uuid(bibl_uuid, image_id)
    
    assert_equal mods_uuid, "510d47e0-bf60-a3d9-e040-e00a18064a99"
  end
  
  def test_get_bibl_uuid
    image_id = "1268326"
    bibl_uuid = @client.get_bibl_uuid(image_id)
    
    assert_equal bibl_uuid, "12deb230-c603-012f-b946-58d385a7bc34"
  end
  
  def test_get_highreslink
    bibl_uuid = "12deb230-c603-012f-b946-58d385a7bc34"
    image_id = "1268326"
    highreslink = @client.get_highreslink(bibl_uuid, image_id)
    
    assert_equal highreslink, "http://link.nypl.org/mxkEE6DrQsaMZJj24FpWww6"
  end
  
  def test_get_items_since
    since_date = "2012-01-01"
    until_date = "2012-08-16"
    items = @client.get_items_since("%22Map%20Division%22&field=physicalLocation", since_date, until_date)
    assert items.length > 1
    assert_not_nil items[0]["uuid"]
  end
  
  def test_get_capture_items
    container_uuid = "e5bad880-c6cd-012f-160a-58d385a7bc34"
    items = @client.get_capture_items(container_uuid)
    assert items.length > 1
    assert_not_nil items[0]["uuid"]
  end
  
  def test_get_image_id
    container_uuid = "12deb230-c603-012f-b946-58d385a7bc34"
    item_uuid = "510d47e0-bf60-a3d9-e040-e00a18064a99"
    image_id = @client.get_image_id(container_uuid, item_uuid)
    assert image_id == "1268326"
  end
  

  

end
