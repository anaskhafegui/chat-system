# Chat

This is a Dockerized Chat app, using ruby on rails.

* Ruby version:- 2.3.6

* Rails version:- 5.2.6

## Dependencies

* a clone of this repo on your machine
* [Docker](https://docs.docker.com/)

## Run the app in your machine: -

* clone the project and setup the env file

```bash

git clone https://github.com/anaskhafegui/chat-system
cd chat-system
```

* rename the .env-example to .env and edit the environment variable as you like

* run the docker-compose

```bash
docker-compose up -d
```

## How to run the test suite

```bash
docker-compose exec -e "RAILS_ENV=test" app bundle exec rspec
```

## Services

* sidekiq
* radis
* elasticsearch
* mysql

## Endpoints

* POST requests

```url
/applications
/{application_token}/chats
/{application_token}/chats/{chat_number}/messages
```

* GET requests

```url
/ 
/{application_token}/chats
/{application_token}/chats/{chat_number}/messages
```

## API Endpoints

### Default Path

```url
/api/v1/
```

#### GET /

Verifies that application is up and running.

##### Sample response

```json

{
    "status": "SUCCESS", 
    "message": "Chat app runnig successfully",
    "data": null 
}
```

### POST Endpoints

#### POST /applications

Creates a new application.

##### Sample body request (required)

```json

{
    "name": "NewApplication", 
}
```

##### Sample response

```json

{
    "status": "SUCCESS",
    "message": "Chat created successfully",
    "data": {
        "app_name": "NewApplication",
        "chat_number": 1,
        "messages_count": 0,
        "created_at": "2022-01-17T21:03:45.000Z"
    }
}
```

#### POST /{application_token}/chats

Creates a new chat with an application token provided

##### Sample response

```json

{
    "status": "SUCCESS",
    "message": "Chat created successfully",
    "data": {
        "app_name": "NewApplications",
        "chat_number": 1,
        "messages_count": 0,
        "created_at": "2022-01-17T21:03:45.000Z"
    }
}
```

#### POST /{application_token}/chats/{chat_number}/messages

Creates a new message with an application token and chat number provided

##### Sample body request (required)

```json

{
    "text": "Hello", 
}
```

##### Sample response

```json

{
    "status": "SUCCESS",
    "message": "Message created successfully",
    "data": {
        "app_name": "NewApplications",
        "chat_number": 1,
        "message_number": 2,
        "text": "Hello",
        "created_at": "2022-01-17T21:05:42.000Z"
    }
}
```

### GET Endpoints

#### GET /{application_token}/chats

Displays all chats listed in the applicatio.

##### Sample response

```json

{
    "status": "SUCCESS",
    "message": "Loaded Application Chats",
    "data": [
        {
            "app_name": "NewApplications",
            "chat_number": 1,
            "messages_count": 2,
            "created_at": "2022-01-17T21:03:45.000Z"
        },
        {
            "app_name": "NewApplications",
            "chat_number": 2,
            "messages_count": 0,
            "created_at": "2022-01-17T21:06:24.000Z"
        }
    ]
}
```

#### GET /{application_token}/chats/{chat_number}/messages

Displays all messages listed in that chat.

##### Optional paramaters

```url

query="{word to search}" (must be string in "example")
```

Sample response:

```json

{
    "status": "SUCCESS",
    "message": "Loaded Application Messages",
    "data": {
        "total_messages": 2,
        "messages": [
            {
                "app_name": "NewApplications",
                "chat_number": 1,
                "message_number": 1,
                "text": "anas",
                "created_at": "2022-01-17T21:05:27.000Z"
            },
            {
                "app_name": "NewApplications",
                "chat_number": 1,
                "message_number": 2,
                "text": "Hello",
                "created_at": "2022-01-17T21:05:42.000Z"
            }
        ]
    }
}
```
