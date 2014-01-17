fs   = require 'fs'
join = require('path').join

Photo = require '../models/photo'

PhotosController =
  index: (req, res, next) ->
    Photo.find {}, (err, photos) ->
      return next(err) if err

      res.render 'index',
        photos: photos

  new: (req, res) ->
    res.render 'new'

  create: (req, res, next) ->
    img  = req.files.photo.image
    name = req.body.photo.name or img.name
    path = join req.app.get('uploads'), img.name

    fs.rename img.path, path, (err) ->
      return next(err) if err

      Photo.create
        name: name
        path: img.name
      , (err) ->
        return next(err) if err

        res.redirect '/'

  show: (req, res, next) ->
    Photo.findById req.params.id, (err, photo) ->
      return next(err) if err

      res.render 'show',
        photo: photo

  destroy: (req, res, next) ->
    Photo.findById req.params.id, (err, photo) ->
      return next(err) if err

      photo.remove (err, photo) ->
        return next(err) if err

        path = join req.app.get('uploads'), photo.name

        fs.unlink path, (err) ->
          return next(err) if err

          res.redirect '/'

module.exports = PhotosController
