import {Application} from 'stimulus'
import {definitionsFromContext} from 'stimulus/webpack-helpers'

const application = Application.start()

const controllers = require.context('../../../controllers', true, /_controller\.js$/)
application.load(definitionsFromContext(controllers))