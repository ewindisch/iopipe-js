const iopipe = require('@iopipe/iopipe');

exports.handler = iopipe((event, context) => {
  context.succeed('This is my serverless function!');
});
