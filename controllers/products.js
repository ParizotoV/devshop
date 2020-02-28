const init = db => {
	const products = require('../models/product')(db)

	const getProduct = async (req, res) => {
		const product = await products.getProductById(req.params.id)
		res.render('product-detail', {
			product
		})
	}
	return {
		getProduct
	}
}

module.exports = init