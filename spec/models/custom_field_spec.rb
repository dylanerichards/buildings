# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomField do
  context 'validations' do
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

    describe 'proper values for field types' do
      context 'when field type is freeform' do
        it 'allows any kind of value' do
          expect do
            CustomField.create(
              field_name: 'broker comment',
              value: "You don't want to miss this!",
              field_type: 'freeform',
              building_id: building.id
            )
          end.to change(CustomField, :count).by 1
        end
      end

      context 'when field type is number' do
        it 'only allows values that can be coerced to decimals' do
          expect do
            CustomField.create(
              field_name: 'bathrooms',
              value: '1.5',
              field_type: 'number',
              building_id: building.id
            )
          end.to change(CustomField, :count).by 1

          expect do
            CustomField.create(
              field_name: 'bathrooms',
              value: 'one point five',
              field_type: 'number',
              building_id: building.id
            )
          end.to change(CustomField, :count).by 0
        end
      end

      context 'when field type is enum' do
        it 'only allows values to be saved that are in the enum_options' do
          expect do
            CustomField.create(
              field_name: 'walkway type',
              value: 'brick',
              field_type: 'enum',
              building_id: building.id,
              enum_options: 'brick, concrete, none'
            )
          end.to change(CustomField, :count).by 1

          expect do
            CustomField.create(
              field_name: 'walkway type',
              value: 'plaster',
              field_type: 'enum',
              building_id: building.id,
              enum_options: 'brick, concrete, none'
            )
          end.to change(CustomField, :count).by 0
        end
      end
    end
  end
end
