const db = require('knex')({
  client: 'mysql2',
  connection: {
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    database: 'devshop'
  }
})

const app = require('./app')(db)

const port = process.env.PORT || 3000

db.on('query', query => {
  console.log('QUERY EXECUTE: ', query.sql)
})

app.listen(port, err => {
  if (err) {
    console.log('Não foi possivel iniciar o servidor.')
  }
  console.log('DevShop server rodando...')
})