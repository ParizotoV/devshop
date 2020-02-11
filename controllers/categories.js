const {
  getProductsByCategorieId
} = require('../models/product')

const {
  getCategoryById
} = require('../models/category')

const getCategories = db => async (req, res) => {
  const products = await getProductsByCategorieId(db)(req.params.id)
  const category = await getCategoryById(db)(req.params.id)
  res.render('category', {
    products,
    category
  })
}

module.exports = {
  getCategories
}