// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import { Application } from 'stimulus'
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()

const controllers = require.context('controllers', true, /_controller\.js$/)
application.load(definitionsFromContext(controllers))