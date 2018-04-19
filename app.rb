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
require 'pdfkit'

PDFKit.configure do |config|
  config.default_options = {
    :page_size => 'A4',
    :print_media_type => true,
    :image_quality => 100,
    :image_dpi => 1200,
    :dpi => 300
  }
  config.verbose = true
end

post "/" do
  status 200
  response.headers['Content-Type'] = 'application/json'
  html = request.body.read

  if html.nil? || html == ''
    status 400
    return fail('400 - Bad request').to_json
  end

  result = PDFKit.new(html).to_pdf
  response.headers['Content-Type'] = 'application/pdf'
  response.headers['Content-Disposition'] = 'inline'
  response.headers['Content-Length'] = result.size
  return result
end

error do
  "something went horribly wrong..." 
end

not_found do 
  status 404
  [].to_json
end
# [END app]
