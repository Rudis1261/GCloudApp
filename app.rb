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
      '/hero/thrall?aspects=role',
      '/hero/thrall?aspects[]=role&aspects[]=name&aspects[]=slug">/hero/thrall?aspects[]=role&aspects[]=name&aspects[]=slug'
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

  # Check if we want specific aspects or children nodes
  if result && params['aspects'] && result[params['name']]
    # Multiple options
    if params['aspects'].is_a?(Array)
      new_result = {}
      params['aspects'].each do |aspect|
        new_result[aspect] = result[params['name']][aspect]
      end
      return new_result.to_json
    end

    # Single string
    if params['aspects'].is_a?(String) && result[params['name']][params['aspects']]
      return result[params['name']][params['aspects']].to_json
    end    
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
