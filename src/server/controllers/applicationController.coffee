module.exports = class applicationController

  class @routes

    @emailRoute = (req, res) ->

      sendgrid = require("sendgrid")(process.env.SENDGRID_USER, process.env.SENDGRID_PASS)

      res.json { err: true } if req.body.email is undefined or req.body.message is undefined

      sendgrid.send {
        to: "sam@sampettersson.com",
        from: req.body.email,
        subject: "Contact form submission",
        text: req.body.message
      }, (err) ->

        if err
          res.json { err: true }

        else
          res.json { err: false }


    @applicationRoute = (req, res) ->

      res.render 'application'
