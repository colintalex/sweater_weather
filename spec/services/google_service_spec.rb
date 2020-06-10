require 'rails_helper'

RSpec.describe GoogleGeoService do
  it "exists" do
    service = GoogleGeoService.new

    expect(service).to be_instance_of GoogleGeoService
  end

  it "can return a latitude and longitude for a city" do
    VCR.use_cassette('geocode', record: :new_episodes) do
      address = 'denver,co'
      service = GoogleGeoService.new
      lat_long = service.get_coords(address)

      expect(lat_long).to have_key(:lat)
      expect(lat_long).to have_key(:lng)
      expect(lat_long[:lat]).to eql(39.7392358)
      expect(lat_long[:lng]).to eql(-104.990251)
    end
  end

  it "can return travel info from an origin and destination" do
    VCR.use_cassette('directions') do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'
      service = GoogleGeoService.new
      directions = service.get_directions(origin, destination)

      expect(directions).to have_key(:routes)
      expect(directions[:routes].first).to have_key(:legs)
      expect(directions[:routes].first[:legs].first).to have_key(:duration)
      expect(directions[:routes].first[:legs].first[:duration]).to have_key(:text)
    end
  end

  it "can return a photo reference id" do
    VCR.use_cassette('photo_reference') do
      location = 'Denver,CO'
      service = GoogleGeoService.new
      ref = service.get_photo_reference(location)

      photo_ref = ref[:candidates][0][:photos][0][:photo_reference]
      expect(photo_ref).to eql( "CmRaAAAANQ9bDCdAgl7jV7mHwsEseTgYs8--oNmI_eWje2l6EVITBAkkYZUBAvURJ8sOxMAvLkTmr-UkN1LBn6ymrSTBgnCG2L9ljWREPRmY1go10ZcH2l0uWGRmvSytvxNdpyClEhDBaIue5_ANmBnHlTGgfL_vGhRmN7UJC0Q5tOzQXTTbTDQxn45S0w")
    end
  end

  it "can return a photo url using a reference id" do
    ref =  "CmRaAAAAE1mdDV2FTRlnumLhchOwXuClxOGBOxHCwFV4MhYL6vS3rL1rbuZ2K-dm3aoaGj9U3Y6Y7JCFRsuBxDmzs96cAuPR4pIwOTJBHV7lykQ-6V4HUV0zAnWEd573DwNCnkQ2EhCcwlIP5PtJeqOVBon6mPYhGhRgtUTHbzchsvrVZJKnjn8HZKRATQ"
    VCR.use_cassette('photo_url') do
      maxheight = '400'
      service = GoogleGeoService.new
      photo_url = service.get_photo_url(ref)

      expect(photo_url).to eql( "https://lh3.googleusercontent.com/p/AF1QipOB9bbho9gPmGyOjUX5of99x-LRYfH_RNETR9EX=s1600-h400")
    end
  end
end
