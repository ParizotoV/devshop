const init = db => {
  const express = require('express')
  const app = express()

  app.set('view engine', 'ejs')
  app.use(express.static('public'))

  const {
    getCategories
  } = require('./models/category')

  const routes = require('./routes')

  // middleware
  app.use(async (req, res, next) => {
    const categories = await getCategories(db)()
    res.locals = {
      categories
    }
    next()
  })

  app.use(routes(db))
  return app
}

module.exports = init