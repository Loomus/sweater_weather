require "rails_helper"

describe "Acount Creation" do
  it "returns an api_key" do
    allow(SecureRandom)
      .to receive(:urlsafe_base64)
      .and_return("Kgs1XMbmJMzj-iVyz8ZWbg")

    post "/api/v1/users?email=whatever@example.com&password=password&password_confirmation=password"

    expect(response).to be_successful
    api_key = JSON.parse(response.body)

    expect(api_key["data"].count).to eq(3)
    expect(api_key["data"]["attributes"]["api_key"]).to eq("Kgs1XMbmJMzj-iVyz8ZWbg")
  end
end
