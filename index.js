const express = require('express')
const app = express()
const port = process.env.PORT || 3000

const db = require('knex')({
  client: 'mysql2',
  connection: {
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    database: 'devshop'
  }
})

const { 
  getCategories, 
  getCategoryById 
} =  require('./models/category')

const {
  getProductsByCategorieId
} = require('./models/product')

db.on('query', query => {
  console.log('QUERY EXECUTE: ', query.sql)
})

app.set('view engine', 'ejs')
app.use(express.static('public'))

app.get('/', async(req, res) => {
  const categories = getCategories(db)()
  res.render('home', { categories })
})

app.get('/categoria/:id/:slug', async(req, res) => {
  const categories = await getCategories(db)()
  const products = await getProductsByCategorieId(db)(req.params.id)
  const category = await getCategoryById(db)(req.params.id)
  res.render('category', {
    products,
    categories,
    category
  })
})

app.listen(port, err => {
  if(err) {
    console.log('Não foi possivel iniciar o servidor.')
  }
  console.log('DevShop server rodando...')
})