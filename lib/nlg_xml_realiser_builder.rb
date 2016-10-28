require "nlg_xml_realiser_builder/version"
require "nlg_xml_realiser_builder/consts"
require "nlg_xml_realiser_builder/dsl"
require "nokogiri"
require "net/http"
require "uri"

module NlgXmlRealiserBuilder
  def self.test_post(text)
    uri = URI.parse("#{ENV['SERVICE_URL'] || 'http://nlg-service.herokuapp.com'}/api/realiser")
    response = Net::HTTP.post_form(uri, {"xml" => text})
    puts response.body
  end
end
