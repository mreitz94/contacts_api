# Contacts API

REST API that allows you to manage contacts.

A contact is a document that contains id, first_name, last_name, phone, and email.
First and last name can never be blank, phone and email are optional fields and may be blank or not provided at all.

## Requirements

The Ruby and RoR versions used for this project:

 * Ruby 2.3.1
 * Rails 5.1

## Installation

Download the project to a local directory.

To initalize the mysql database on localhost edit the config/database.yml to include the following (replacing username and password with the correct credentials):

```yaml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password:
  socket: /tmp/mysql.sock

development:
  <<: *default
  database: contacts_api_development

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: contacts_api_test
```

To initialize the project run the startup script:

```shell
sh start.sh
```

The above script actually runs the following 3 commands, to bundle and install the project, create the mysql schema, and migrate the contacts table:

```shell
bundle install
rake db:create
rake db:migrate
```

## Usage

To start the server:

```shell
rails s
```

Now the API can be accessed from any of your browsers or 3rd party API applications such as Postman through the URL: `http://localhost:3000/contacts`

# Contacts CRUD Operations

## 1 Creating a New Contact

This endpoint creates a new contact

### 1.1 HTTP Request

```POST http://localhost:3000/contacts```

### 1.2 Query Parameters

| Field         | Type          | Required |
| ------------- |:-------------:| -----:|
| first_name    | string        | required |
| last_name     | string        | required |
| phone         | string        | _optional_ |
| email         | string        | _optional_ |

### 1.3 Sample Request and Response

```POST http://localhost:3000/contacts?first_name=John&last_name=Doe&phone=8005559000&email=johndoe@email.com```

```json
{
    "message": "Contact created successfully",
    "contact": {
        "id": 1,
        "first_name": "John",
        "last_name": "Doe",
        "phone": "8005559000",
        "email": "johndoe@email.com",
        "created_at": "2017-11-17T17:44:34.000Z",
        "updated_at": "2017-11-17T17:44:34.000Z"
    }
}
```

## 2 Updating Existing Contact

This endpoint updates an existing contact

### 2.1 HTTP Request

```PATCH http://localhost:3000/contacts/:id```

### 2.2 URL Parameters

| Field         | Description |
| ------------- |:-------------:|
| id    | id of the contact |

### 2.3 Query Parameters

| Field         | Type          |
| ------------- |:-------------:|
| first_name    | string        |
| last_name     | string        |
| phone         | string        |
| email         | string        |

### 2.4 Sample Request and Response

```PATCH http://localhost:3000/contacts/1?phone=8005557777```

```json
{
    "message": "Contact updated successfully",
    "contact": {
        "id": 1,
        "phone": "8005557777",
        "first_name": "John",
        "last_name": "Doe",
        "email": "johndoe@email.com",
        "created_at": "2017-11-17T17:44:34.000Z",
        "updated_at": "2017-11-17T17:54:10.000Z"
    }
}
```

## 3 Listing Contacts

This endpoint lists all of the contacts

### 3.1 HTTP Request

```GET http://localhost:3000/contacts```

### 3.2 Sample Request and Response

```GET http://localhost:3000/contacts```

```json
[
    {
        "id": 1,
        "first_name": "John",
        "last_name": "Doe",
        "phone": "8005557777",
        "email": "johndoe@email.com",
        "created_at": "2017-11-17T17:44:34.000Z",
        "updated_at": "2017-11-17T17:54:10.000Z"
    },
    {
        "id": 2,
        "first_name": "Jane",
        "last_name": "Doe",
        "phone": "80055511111",
        "email": "janedoe@email.com",
        "created_at": "2017-11-17T15:54:01.000Z",
        "updated_at": "2017-11-17T17:54:01.000Z"
    },
    {
        "id": 3,
        "first_name": "Tim",
        "last_name": "Smith",
        "phone": null,
        "email": null,
        "created_at": "2017-11-17T17:58:24.000Z",
        "updated_at": "2017-11-17T17:58:24.000Z"
    },
    {
        "id": 4,
        "first_name": "Emily",
        "last_name": "Jones",
        "phone": null,
        "email": null,
        "created_at": "2017-11-17T17:58:36.000Z",
        "updated_at": "2017-11-17T17:58:36.000Z"
    }
]
```

## 4 Listing a Single Contact

This endpoint lists a single contact

### 4.1 HTTP Request

```GET http://localhost:3000/contacts/:id```

### 4.2 URL Parameters

| Field         | Description |
| ------------- |:-------------:|
| id    | id of the contact |

### 4.3 Sample Request and Response

```GET http://localhost:3000/contacts/1```

```json
{
    "id": 1,
    "first_name": "John",
    "last_name": "Doe",
    "phone": "8005557777",
    "email": "johndoe@email.com",
    "created_at": "2017-11-17T17:44:34.000Z",
    "updated_at": "2017-11-17T17:54:10.000Z"
}
```

## 5 Deleting a Contact

This endpoint deletes a single contact

### 5.1 HTTP Request

```DELETE http://localhost:3000/contacts/:id```

### 5.2 URL Parameters

| Field         | Description |
| ------------- |:-------------:|
| id    | id of the contact |

### 5.3 Sample Request and Response

```DELETE http://localhost:3000/contacts/4```

```json
{
    "message": "Contact deleted successfully"
}
```

