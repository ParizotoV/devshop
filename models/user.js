const bcrypt = require('bcryptjs')

const generatePassHash = passwd => {
	const salt = bcrypt.genSaltSync(10)
	const hash = bcrypt.hashSync(passwd, salt)
	return hash
}

const initialUser = db => async (id) => {
	const user = await db('users').count('id as total')
	console.log(user)
	if(user[0].total === 0 ) {
		// create admin
		const user = {
			name: 'Admin',
			email: 'vini.parizoto@live.com',
			passwd: generatePassHash('123'),
			email_checked: 'true',
			created: new Date(),
			updated: new Date(),
			roles: 'admin,financial,customer'
		}
		await db('users').insert(user)
	}
  if (user.length > 0) {
    return user[0]
  }
  return {}
}

const login = db => async(email, passwd) => {
	const user = await db('users').select('*').where('email', email)
	console.log('user', user)
	if(user.length === 0) {
		throw new Error('Invalid user.')
	}
	console.log('passwd', passwd)
	if (!bcrypt.compareSync(passwd, user[0].passwd)) {
		throw new Error('Invalid password.')
	}
	return user[0]
}

module.exports = {
	initialUser,
	login
}