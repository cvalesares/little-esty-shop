require 'rails_helper'

RSpec.describe HolidayService do
  it "returns data about a holiday" do
    mock_response = "({"date": "2021-11-25",
      "localName": "Thanksgiving Day",
      "name": "Thanksgiving Day",
      "countryCode": "US",
      "fixed": false,
      "global": true,
      "counties": null,
      "launchYear": 1863,
      "types": ["Public"]
      })"

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    json = HolidayService.holidays

    expect(json).to be_a Hash
    expect(json).to have_key :name

  end
end
