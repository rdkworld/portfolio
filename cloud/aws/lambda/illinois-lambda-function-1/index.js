var request = require('request');
exports.handler = async (event) => {
    // TODO implement
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda! 122222'),
    };
    
  return response;
};
