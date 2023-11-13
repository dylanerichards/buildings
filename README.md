# Buildings API

## Background

A platform that stores a list of physical buildings.


## Running the Application
- Clone the repository and `cd` into it
- Install dependencies by running `bundle install`
- Set up the database: `bundle exec rake db:create db:migrate`
- Seed the database: `bundle exec rake db:seed`
    -   The seeds create 5 Clients. 2 Buildings per client, and 2 CustomFields per Building.
- Start the server: `bin/dev` or `rails server`. The app starts at `localhost:3000`


## Usage
- You can create a new Client by signing up at `localhost:3000/clients/sign_up`, but I recommend just using a Client from the seeds:
    -   username: dylan@dylan.com
    -   password: "password"


### Endpoints
The app exposes a numnber of endpoints for creating and updating Buildings:

### Create a building
`POST /buildings`

Creates a building. Includes an interface for creating custom fields.

Sample payload:
 ```
 {
    "building": {
        "client_id": "1",
        "address": "1085 Broadway",
        "city": "Brooklyn",
        "state": "New York",
        "zip": "11221"
    },
    "custom_fields": [
        {
            "field_name": "bathrooms",
            "value": "out",
            "field_type": "enum",
            "enum_options": "in, out, none"
        },
         {
            "field_name": "bedrooms",
            "value": "1",
            "field_type": "number"
        }
    ]
}
 ```
### Update a building
`PATCH /buildings/:id`

Updates a building by ID.

Sample payload:
```
{
    "building": {
        "client_id": "4",
        "address": "1085 Broadway",
        "city": "Manhattan",
        "state": "New York",
        "zip": "11221"
    }
}
```
 
### Get all buildings (paginated, 2 per page)
`GET /buildings`

Gets a paginated list of all the Buildings in the platform.
Supply a `page` parameter to fetch subsequent Buildings. e.g. `/buildings?page=2`

### Bonus: An endpoint to update the value of a custom field
`PATCH /custom_fields`

Can update the value and type of an existing CustomField. The building's ID and the field name must be known and passed into the endpoint.
```
{
    "building_id": 1,
    "field_name": "bathrooms",
    "value": "closed",
    "field_type": "enum",
    "enum_options": "open, closed, semi"
}
```
