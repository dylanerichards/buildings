# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do
  describe '#create' do
    let(:client) do
      Client.create(
        name: 'dylan',
        email: 'dylan@dylan.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'creates a building' do
      post :create, params: {
        building: {
          address: '1085 Broadway',
          city: 'Brooklyn',
          zip: '11221',
          client_id: client.id
        },
        custom_fields: [
          { field_name: 'bathrooms', value: '1.5', field_type: 'number' },
          { field_name: 'pets', value: 'yes', field_type: 'freeform' },
          { field_name: 'floorplan', value: 'open', field_type: 'enum', enum_options: 'closed, open, loft' }
        ]
      }

      expect(Building.count).to eq 1
      expect(Building.first.address).to eq '1085 Broadway'
      expect(Building.first.client).to eq client

      expect(JSON.parse(response.body)).to eq({
                                                'building' => {
                                                  'id' => Building.first.id,
                                                  'address' => '1085 Broadway',
                                                  'city' => 'Brooklyn',
                                                  'zip' => '11221',
                                                  'client' => client.name,
                                                  'custom_fields' => [{ 'bathrooms' => '1.5' }, { 'pets' => 'yes' },
                                                                      'floorplan' => 'open']
                                                },
                                                'message' => 'success'
                                              })
    end
  end

  describe '#update' do
    let(:client) do
      Client.create(
        name: 'dylan',
        email: 'dylan@dylan.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    let(:building) do
      Building.create(
        address: '1085 Broadway',
        city: 'Brooklyn',
        zip: '11221',
        client_id: client.id
      )
    end

    it 'updates an existing building' do
      patch :update, params: {
        id: building.id,
        building: {
          address: '0 Bond',
          city: 'New York',
          zip: '10003'
        }
      }

      expect(Building.first.city).to eq 'New York'
      expect(Building.first.client).to eq client

      expect(JSON.parse(response.body)).to eq({
                                                'message' => 'success',
                                                'building' => {
                                                  'id' => Building.first.id,
                                                  'address' => '0 Bond',
                                                  'city' => 'New York',
                                                  'zip' => '10003',
                                                  'client' => client.name,
                                                  'custom_fields' => []
                                                }
                                              })
    end
  end

  describe '#index' do
    before do
      Building.create(
        address: '1085 Broadway',
        city: 'Brooklyn',
        zip: '11221',
        client_id: client.id
      )

      Building.create(
        address: '1090 Broadway',
        city: 'Brooklyn',
        zip: '11221',
        client_id: client.id
      )

      Building.create(
        address: '1100 Broadway',
        city: 'Brooklyn',
        zip: '11221',
        client_id: client.id
      )
    end

    let(:client) do
      Client.create(
        name: 'dylan',
        email: 'dylan@dylan.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'returns all the buildings' do
      get :index

      expect(response.body).to eq(
        ActiveModel::SerializableResource.new(
          Building.first(2),
          each_serializer: BuildingSerializer
        ).to_json
      )
    end
  end
end
