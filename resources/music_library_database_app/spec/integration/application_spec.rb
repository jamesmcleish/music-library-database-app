require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  context 'post and /albums' do
    it 'creates new albums' do
      response = post('/albums', title: 'voyage', release_year: 2022, artist_id: 2)
      response2 = get('/albums')
      expect(response.status).to eq 200
      expect(response.body).to eq ''
      expect(response2.body).to include 'voyage'
    end
  end
  context 'GET /albums' do
    it 'get request returns all albums title' do
      response = get('/albums')
      expect(response.status).to eq 200
      expect(response.body).to include 'Surfer Rosa'
    end
  end
  context 'GET /artists' do
    it 'get request returns all artist names' do
      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'
    end
  end
  context 'POST /artists' do
    it 'creates new artist' do
      response = post('/artists', name: 'fleetwood mac', genre: 'pop')
      response2 = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to eq ''
      expect(response2.body).to include 'fleetwood mac'
    end
  end
end

