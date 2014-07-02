# Selfie Sign In

A low-security login method for meteor, using selfies.

To create an acocunt, user is required to submit an image.

It becomes their avatar for the duration of the session.

## Packages Used

* CollectionFS
* cfs-gridfs
-----* user-status
* graphicsmagick

## Quickstart

Install using meteorite

```
$ mrt add selfie-sign-in
```

Place the login template using

```
{{> selfie_sign_in}}
```

The template will ask the user to submit a picture using the HTML5 API. If the user has a mobile device with a camera, they are also given a choice to send a photograph.

Once the file is submitted, it is converted on the server using graphicsmagick. It is inserted into mongo's GridFS with large and thumbnail sized copies.

Finally, the image id is stored with the user that has just logged in, and is made accessible using CollectionFS's helpers

```
{{this.url store='thumbnail'}}
```

## Features/Components

* A login system with GUI
* An API for accessing/viewing the image on a user (use CFS getFile)
* Mobile API
* Works out of the box with zero config, configurable if needed


## Configure

* Change storage options - Default is Mongo's GridFS







