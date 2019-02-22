const iopipe = require('@iopipe/iopipe')({ token: 'PROJECT_TOKEN' });

exports.handler = iopipe((event, context) => {
  context.succeed('This is my serverless function!');
});
