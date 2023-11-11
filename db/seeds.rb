# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


clients = ["dylan", "tony", "renee", "regina", "brandon"]

clients.each do |client|
   c = Client.create(
    name: client,
    email: "#{client}@#{client}.com",
    password: "password", 
    password_confirmation: "password"
  ) 

  building = Building.create(
    address: "1 #{client} Way",
    city: "New York",
    state: "New York",
    zip: "11221",
    client_id: c.id
  )

  CustomField.create(
    building_id: building.id,
    field_name: "pets",
    value: "allowed",
    field_type: "freeform"
  )

  CustomField.create(
    building_id: building.id,
    field_name: "bathrooms",
    value: "1.5",
    field_type: "number"
  )

  building = Building.create(
    address: "2 #{client} Way",
    city: "New York",
    state: "New York",
    zip: "11221",
    client_id: c.id
  )

  CustomField.create(
    building_id: building.id,
    field_name: "luxury",
    value: "yes",
    field_type: "freeform"
  )

  CustomField.create(
    building_id: building.id,
    field_name: "pre-war",
    value: "yes",
    field_type: "freeform"
  )
end
