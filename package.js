Package.describe({
  summary: 'An insecure sign-in package using selfies'
});

Package.on_use(function (api) {
  api.use(['underscore','templating'], 'client');
  api.use(['coffeescript','accounts-testing'], ['client','server'])

  api.add_files([
    'client/selfie-sign-in.html',
    'client/selfie-sign-in-client.coffee'
  ], 'client');

  api.add_files([
    'server/selfie-sign-in-server.coffee'
  ], 'server');
});
