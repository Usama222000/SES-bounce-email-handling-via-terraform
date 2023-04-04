
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';
import * as https from 'https';
const client = new DynamoDBClient({});
const ddbDocClient = DynamoDBDocumentClient.from(client);
const yourWebHookURL = process.env.slack_url;
const tableName = process.env.table_name;
export const lambda_handler = async (event) => {
  const message = JSON.stringify(event.Records[0].Sns.Message);
  const messageID = JSON.stringify(event.Records[0].Sns.MessageId);
  // const messageId = message.mail.messageId;
  // const bounceType = message.bounce.bounceType;
  // const sender = message.mail.source;
  const userAccountNotification = {
    'username': 'usama.ahmed', 
    'text': 'The email sent is bounced', 
    'icon_emoji': ':bangbang:', 
    'attachments': [{ 
      'color': '#eed140', 
      'fields': [ 
        {
          'title': 'messageID',
          'value': messageID,
          'short': true
        }
        // {
        //   'title': 'sender',
        //   'value': sender,
        //   'short': true
        // },
        // {
        //   'title': 'Bounce Type',
        //   'value': bounceType,
        //   'short': true
        // }
      ]
    }]
  };
  // const addresses = message.bounce.bouncedRecipients.map(function(recipient){
  //   return recipient.emailAddress;
  //   });
    const item = {
             MessageId: messageID,
            // newbody: message,
            // bounceTybe: bounceType,
            // sender: sender,
           // test: JSON.stringify(test)
            body: message
    };
    const params = {
            TableName:tableName,
            Item: item
            
        };
    try {
        const data = await ddbDocClient.send(new PutCommand(params));
        const slackResponse = await sendSlackMessage(yourWebHookURL, userAccountNotification);
        console.log("Success - item added or updated", data);
        // console.log('Message response', slackResponse);
      } catch (err) {
        console.log("Error", err.stack);
      }
  
   
    const response = {
        statusCode: 200,
      
    };

    return response;
};
/**
 * Handles the actual sending request. 
 * We're turning the https.request into a promise here for convenience
 * @param webhookURL
 * @param messageBody
 * @return {Promise}
 */
 function sendSlackMessage (webhookURL, messageBody) {
  // make sure the incoming message body can be parsed into valid JSON
  try {
    messageBody = JSON.stringify(messageBody);
  } catch (e) {
    throw new Error('Failed to stringify messageBody', e);
  }

  // Promisify the https.request
  return new Promise((resolve, reject) => {
    // general request options, we defined that it's a POST request and content is JSON
    const requestOptions = {
      method: 'POST',
      header: {
        'Content-Type': 'application/json'
      }
    };

    // actual request
    const req = https.request(webhookURL, requestOptions, (res) => {
      let response = '';


      res.on('data', (d) => {
        response += d;
      });

      // response finished, resolve the promise with data
      res.on('end', () => {
        resolve(response);
      })
    });

    // there was an error, reject the promise
    req.on('error', (e) => {
      reject(e);
    });

    // send our message body (was parsed to JSON beforehand)
    req.write(messageBody);
    req.end();
  });
}


