const init = db => {
  const express = require('express')
	const app = express()
	const bodyParser = require('body-parser');
	const session = require('express-session')

  app.set('view engine', 'ejs')
	app.use(express.static('public'))
	app.use(bodyParser.urlencoded({ extended: true }))
	app.use(bodyParser.json({ extended: true }))

	app.use(session({
		secret: 'MyDevShopRulez',
		name: 'sessionId'
	}))

  const {
    getCategories
  } = require('./models/category')(db)

  const routes = require('./routes')

  // middleware
  app.use(async (req, res, next) => {
		const { user } = req.session
    const categories = await getCategories()
    res.locals = {
			categories,
			user
    }
    next()
  })

  app.use(routes(db))
  return app
}

module.exports = init