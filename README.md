# Contacts API

REST API that allows you to manage contacts.

A contact is a document that contains id, first_name, last_name, phone, and email.
First and last name can never be blank, phone and email are optional fields and may be blank or not provided at all.

## Installation

Download the project to a local directory and from the command line:

```shell
bundle install
```

To initalize the mysql database on localhost edit the config/database.yml to include the following (replacing username and password with the correct credentials):

```shell
rake db:create
```

This will create the schema for the project

To add the contacts table (where the data is stored):

```shell
rake db:migrate
```

## 1 Usage

To start the server:

```shell
rails s
```

## 2 Contacts

### 2.1 Creating a New Contact

This endpoint creates a new contact

#### HTTP Request

'POST http://localhost:3000/contacts'

#### Query Parameters

| Field         | Type          | Required |
| ------------- |:-------------:| -----:|
| first_name    | string        | required |
| last_name     | string        | required |
| phone         | string        | _optional_ |
| email         | string        | _optional_ |

#### Sample Request and Response

'POST http://localhost:3000/contacts?first_name=John&last_name=Doe&phone=8005559000&email=johndoe@email.com'

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
