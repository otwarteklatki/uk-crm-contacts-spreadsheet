require 'http'
require 'sendgrid-ruby'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

# API query 1
# ===========
# https://docs.sendgrid.com/api-reference/contacts/export-contacts
# This POST request makes SendGrid create a new export file for all contacts, which will be visible at https://mc.sendgrid.com/contacts/exports
# when ready. It takes a few seconds to create and is deleted after 12 hours. We can specify it to create either a csv or a json.

response = sg.client.marketing.contacts.exports.post(query_params: { file_type: "json" } )
export_id = response.parsed_body[:id]

# API query 2
# ===========
# https://docs.sendgrid.com/api-reference/contacts/import-contacts-status
# This GET request gets the url for downloading the newly created export file. As of today the export file is about 4MB.

def get_export_url(sg_client, export_id)
  sg_client.marketing.contacts.exports.get(query_params: {id: export_id})
end

response = get_export_url(sg.client, export_id)

# The response body result in response.parsed_body[:result] is a list of the all available exports to download, with the newest last.
# status: if this is "ready", the export is ready to download.
# urls: a list of urls to download it at (this would be more than one if we had set a low maximum file size, but the
# default max is 5000MB)

until response.parsed_body[:result].last[:status] == "ready" do
  sleep(1) # Sleep is important! Don't want to hit a query limit.
  response = get_export_url(sg.client, export_id)
end

export_url = response.parsed_body[:result].last[:urls].first

# Query 3
# =======
# We GET request the url of the export file to download the file. This url appears to be valid for 300 seconds,
# since it contains "X-Amz-Expires=300"

puts export_url

export_download = HTTP.get(export_url)

pp export_download
