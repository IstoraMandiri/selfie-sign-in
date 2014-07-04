Package.describe({
  summary: 'An insecure sign-in package using selfies'
});

Package.on_use(function (api) {
  api.use(['ui','templating'], 'client');
  api.use([
    'collectionFS',
    'accounts-base',
    'cfs-graphicsmagick',
    'cfs-gridfs',
    'coffeescript'
  ], ['client','server']);

  api.add_files([
    'client/selfie-sign-in.html',
    'client/selfie-sign-in-client.coffee'
  ], 'client');

  api.add_files([
    'selfie-sign-in.coffee'
  ], ['client','server']);

  api.add_files([
    'server/selfie-sign-in-server.coffee'
  ], 'server');
});
