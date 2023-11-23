# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomFieldsController, type: :controller do
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

    let(:custom_field) do
      CustomField.create(
        building_id: building.id,
        field_name: 'pets',
        value: 'allowed',
        field_type: 'freeform'
      )
    end

    before do
      client
      building
      custom_field
    end

    it 'can be updated' do
      patch :update, params: {
        building_id: building.id,
        field_name: 'pets',
        value: 'not allowed'
      }

      expect(building.custom_fields.last.value).to eq 'not allowed'
    end
  end
end
