const init = db => {
  const router = require('express').Router()
  const {
    getProduct
  } = require('../controllers/products')(db)

  router.get('/:id/:slug', getProduct)

  return router
}

module.exports = init