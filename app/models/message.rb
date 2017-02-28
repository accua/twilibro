require 'httparty'
require 'rest-client'
class Message < ApplicationRecord
  before_create :send_message

private

  def send_message
    begin
      response = RestClient::Request.new(
        :method => :post,
        :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_SID']}/Messages.json",
        :user => ENV['TWILIO_SID'],
        :password => ENV['TWILIO_TOKEN'],
        :payload => {:Body => body,
                     :To => to,
                     :From => from }
        ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
