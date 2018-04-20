# Copyright 2015 Google, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START app]
require "sinatra"
require "json"

heroes_simple = JSON.parse(File.read('./heroes.json'))
heroes_details = JSON.parse(File.read('./hero.json'))

get "/" do
  content_type :json
  { 
    'routes': [
      '/heroes',
      '/hero/thrall',
      '/hero/thrall?prop=role',
      '/hero/thrall?prop[]=role&prop[]=name&prop[]=slug">/hero/thrall?prop[]=role&prop[]=name&prop[]=slug'
    ]
  }.to_json
end

get "/heroes" do
  content_type :json
  heroes_simple.to_json
end

get "/hero/:name" do
  content_type :json

  result = heroes_simple.select do  |key, hero|
    hero['slug'].include? params['name']
  end

  if result && params['prop'] && params['prop'].is_a?(String)
    items = {}
    result.keys.each do |hero_name|
      items[hero_name] = { params['prop'] => result[hero_name][params['prop']] }
    end
    return items.to_json
  end    

  if result && params['prop'] && params['prop'].is_a?(Array)
    items = {}
    result.keys.each do |hero_name|
      entry = {}
      params['prop'].each do |prop|
        entry[prop] = result[hero_name][prop]
      end
      items[hero_name] = entry
    end
    return items.to_json
  end

  result.to_json
end

error do
  "sinatra error handler" 
end

not_found do 
  status 404
  [].to_json
end
# [END app]
