const slug = require('../utils/slug')

const getProductsByCategorieId = db => async (id) => {
  const products = await db('products').select('*').where('id', function () {
    this
      .select('categories_products.product_id')
      .from('categories_products')
      .whereRaw('categories_products.product_id = products.id')
      .where('category_id', id)
  })
  return products
}

const getProductById = db => async (id) => {
  const product = await db('products').select('*').where('id', id)
  if (product.length > 0) {
    return product[0]
  }
  return {}
}

module.exports = {
  getProductsByCategorieId,
  getProductById
}