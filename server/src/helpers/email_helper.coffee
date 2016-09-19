AWS = require 'aws-sdk'
config = require '../config/config'

AWS.config.region = 'us-west-2'

ses = new AWS.SES()

module.exports =
  send: (to, subject, body) ->
    ses.sendEmail
      Source: 'MyDogLacy <accounts@mydoglacy.com>'
      Destination:
        ToAddresses: [to]
      Message:
        Subject:
          Data: subject
        Body:
          Text:
            Data: body
    , (err, data) ->
      console.log 'email helper', err
