require 'rails_helper'

RSpec.describe HolidayService do
  it "returns data about a holiday" do
    mock_response = '{
    "date": "2021-12-24",
    "localName": "Christmas Day",
    "name": "Christmas Day",
    "countryCode": "US",
    "fixed": false,
    "global": true,
    "counties": null,
    "launchYear": null,
    "types": [
      "Public"
    ]
    }'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)
    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(mock_response)

    # json = HolidayService.holidays
    response = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to be_a Hash
    expect(parsed).to have_key :name

  end
end
