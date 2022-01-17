
# Chat

This is a Dockerized Chat app, using ruby on rails.

* Ruby version:- 2.3.6

* Rails version:- 5.2.6

## Dependencies

* a clone of this repo on your machine
* [Docker](https://docs.docker.com/)

## Run the app in your machine: -

```bash

git clone https://github.com/anaskhafegui/chat-app
cd chat-app
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
/application
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
    "data": nil 
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
    "message": "Application created successfully", 
    "data":{
        "name": "NewApplication",
        "chats_count": 0,
        "created_at": "2022-01-15T19:51:10.000Z",
        "updated_at": "2022-01-15T19:51:10.000Z",
        "token": "Ph3Sekqq99LTjrTTngbwXAqwHeTBtKoXvG3dRAz4GL6gEot4MTkCgfnCPGn8"
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
}
```

#### POST /{application_token}/chats/{chat_number}/messages

Creates a new message with an application token and chat number provided

##### Sample body request (required):

```json

{
    "text": "Hello", 
}
```

##### Sample response:

```json

{
    "status": "SUCCESS", 
    "message": "Message created successfully", 
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
            "chat_number": 1,
            "messages_count": 1,
            "created_at": "2022-01-15T20:50:33.000Z",
            "updated_at": "2022-01-15T21:03:34.000Z"
        },
        {
            "chat_number": 2,
            "messages_count": 0,
            "created_at": "2022-01-15T21:05:32.000Z",
            "updated_at": "2022-01-15T21:05:32.000Z"
        }
    ]
}
```

#### GET /{application_token}/chats/{chat_number}/messages

Displays all messages listed in that chat.

##### Optional paramaters

```url

query={word to search}
```

Sample response:

```json

{
    "status": "SUCCESS",
    "message": "Message",
    "data": {
        "messages": [
            {
                "text": "Anas",
                "message_number": 1,
                "created_at": "2022-01-15T21:03:34.000Z",
                "updated_at": "2022-01-15T21:03:34.000Z"
            },
            {
                "text": "Hello",
                "message_number": 2,
                "created_at": "2022-01-15T21:08:12.000Z",
                "updated_at": "2022-01-15T21:08:12.000Z"
            }
        ],
        "total_messages": 2
    }
}
```
