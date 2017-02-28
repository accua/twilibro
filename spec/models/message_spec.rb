require 'rails_helper'

describe Message, :vcr => true do
  it "adds an error if the from number is invalid" do
    message = Message.new(to: 111111111, from: 5033032929, body: 'bro')
    message.save
    expect(message.errors.messages[:base]).to eq ["The 'From' number 5033032929 is not a valid phone number, shortcode, or alphanumeric sender ID."]
  end

  it "adds an error if the to number is invalid" do
    message = Message.new(to: 111111, from: 5595542742, body: 'bro')
    message.save
    expect(message.errors.messages[:base]).to eq ["The 'To' number 111111 is not a valid phone number."]
  end
end
