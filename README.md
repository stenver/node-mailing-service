# Node Mailing Service

A simple service that consumes messages from kafka queues and then sends an email

## Running locally
Install packages, coffeescript and then specify environmental variables when calling start script
```
npm install
npm install -g coffee-script
EMAIL_USER=user@email.com EMAIL_PASSWORD=yoursecret HOST=mailing.host.com SSL=true ./start
```
You can now send messages to kafka to the topic "node-email". The message must be a hash, containing the following key-values:
```
{
  "from": "stenver1010@gmail.com, # Required
  "to": "stenver1010@gmail.com",  # Required
  "cc": "stenver1010@gmail.com",  # Optional
  "bcc": "stenver1010@gmail.com", # Optional
  "subject": "some nice subject", # Optional
  "text": "Some cool text"        # Optional
}
```

You can also specify multiple receivers as a comma separated list and you can specify the display name
```
"to": "stenver <stenver1010@gmail.com>, example <example@gmail.com"
```

## Running from docker

```
docker build -t node-mailing-service .
docker run -e="EMAIL_USER=user@email.com" -e="EMAIL_PASSWORD=yoursecret" -e="HOST=mailing.host.com" node-mailing-service
```
