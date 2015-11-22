#!/usr/bin/env coffee

EmailConsumer = require './lib/email_consumer'
emailjs = require("emailjs/email")
kafka = require 'kafka-node'

user = process.env.EMAIL_USER
password = process.env.EMAIL_PASSWORD
host = process.env.HOST
ssl = process.env.SSL || true

console.log(user, password, host, ssl)
emailjsserver  = emailjs.server.connect({
   user:    user,
   password:password,
   host:    host,
   ssl:     ssl
})

messageConsumer = new kafka.HighLevelConsumer(
  new kafka.Client(), [{ topic: 'node-email'}]
)

emailConsumer = new EmailConsumer(emailjsserver, messageConsumer)
emailConsumer.start()

