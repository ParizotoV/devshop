const init = db => {
	const slug = require('../utils/slug')
	const getPaginationParams = query => {
		const { currentPage, pages, pageSize } = query
		return {
			currentPage: currentPage ? parseInt(currentPage) : 0,
			pages: pages ? parseInt(pages) : 1,
			pageSize: pageSize ? parseInt(pageSize) : 10
		}
	}
	const getProductsByCategorieId = async (id, query) => {
		const pagination = getPaginationParams(query)
		const products = await db('products').select('*').whereIn('id', function () {
			this
				.select('categories_products.product_id')
				.from('categories_products')
				.where('category_id', id)
		}).offset(pagination.currentPage * pagination.pageSize).limit(pagination.pageSize)

		const productsCount = await db('products').count('* as total').whereIn('id', function () {
			this
				.select('categories_products.product_id')
				.from('categories_products')
				.where('category_id', id)
		}).first()
		pagination.total = productsCount.total
		pagination.totalPages = Math.ceil(parseInt(productsCount.total / pagination.pageSize))
		return {
			data: products,
			pagination
		}
	}

	const getProductById = async (id) => {
		const product = await db('products').select('*').where('id', id)
		if (product.length > 0) {
			return product[0]
		}
		return {}
	}
	return {
		getProductsByCategorieId,
		getProductById
	}
}

module.exports = init