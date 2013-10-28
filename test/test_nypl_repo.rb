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
    @client = NyplRepo::Client.new(ENV["API_TOKEN"])
  end

  def test_init
    client = NyplRepo::Client.new(ENV["API_TOKEN"])
    assert_not_nil client
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
  

end
