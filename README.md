# nypl_repo

A Ruby Gem for the New York Public Libraries Digital Collections Repository API at http://api.repo.nypl.org/

## Usage

```
token = "your_nypl_api_token"
client = NyplRepo::Client.new(token)
```
additionally, an options hash can be passed in, all optional.
```
token = "your_nypl_api_token"
options = {:debug => true, :server_url => "http://example.com/api/v2/"}
client = client = NyplRepo::Client.new(token, options)
```

### Initialisation Options

Setting `:debug` to true puts a number of debugging statements

The default `:server_url` is http://api.repo.nypl.org/api/v1

### Examples
```
token = "your_nypl_api_token"
client = NyplRepo::Client.new(token)
mods_uuid = "510d47e2-8e15-a3d9-e040-e00a18064a99"
mods_item = client.get_mods_item(mods_uuid)
```
```
token = "your_nypl_api_token"
client = NyplRepo::Client.new(token)
bibl_uuid = "12deb230-c603-012f-b946-58d385a7bc34"
image_id = "1268326"
mods_uuid  = client.get_mods_uuid(bibl_uuid, image_id)
```

## Methods

`item_uuid` also known as `mods_uuid` refers to the actual item itself, so for example, a map.

`container_uuid` also known as `bibl_uuid` refers the the bibliographic container. For example it would be an Atlas, containing individual maps.

* get_mods_item(item_uuid)
* get_mods_uuid(container_uuid, image_id)
* get_bibl_uuid(image_id)
* get_highreslink(container_uuid, image_id)
* get_items_since(query, since_date, until_date)
  * since_date, until_date format YYYY-MM-DD 
  * Returns array of items
  * Will paginate if there are a number of pages - this means it will repeatedly call the API for each call
* get_capture_items(container_uuid)
  * Returns array of items. 
  * Will paginate if there are a number of pages - this means it will repeatedly call the API for each call
* get_image_id(container_uuid, item_uuid)
  
The above methods all use the get_json method, which can also be called directly:
   
* get_json(url)
  * where url is the full API url to be called: example `http://api.repo.nypl.org/api/v1/items/search.json?q=unicorns`


## Tests
```
 API_TOKEN=YourAPIToken rake test
```

With debugging output:
```
DEBUG=true API_TOKEN=YourAPIToken rake test
```


## Author
Copyright 2014 Tim Waters http://github.com/timwaters  
