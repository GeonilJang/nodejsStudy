var express = require('express');
var session = require('express-session');
var badyParser = require('body-parser');
var MySQLStore  = require('express-mysql-session')(session);
var sha256 = require('sha256');
var app = express();
app.use(badyParser.urlencoded({ extended: false}));
app.use(session({
	secret: '123!@#456$%^',
	resave: false,
	saveUninitialized: true,
	store: new MySQLStore({
		 host : 'localhost',
		 port :  3306,
 		 user : 'root',
  		 password : 'root!@#$',
         database : 'serversidejavascript'
	})
}));



/*app.get('/count', function(req, res){

	if(req.session.count){
		req.session.count++;
	}else{
		req.session.count = 1;
	}

	
	res.send('count : ' + req.session.count);
})*/

app.get('/auth/login', function(req, res){

	var output = `
	<h1>Login</h1>
	<form action="/auth/login" method='post'>
		<p>
			<input type="text" , name="username", placeholder="username">
		</p>
		<p>
			<input type="text" , name="password", placeholder="password">
		</p>
		<p>
			<input type="submit">
		</p>
	</form>

	`
	res.send(output);
})

app.post('/auth/login', function(req, res){
	var user = {
		username: 'jgi',
		password: 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',
		displayName: 'geonil'
	}
	var uname = req.body.username;
	var pwd = req.body.password;

	if(uname === user.username && sha256(pwd) === user.password){
		req.session.displayName = user.displayName;
		req.session.save(function(){
			res.redirect('/welcome');
		})
	}else{
		res.send(" ?2131? <a href='/auth/login'>login</a>");
	}
	res.send(uname);
})

app.get('/welcome', function(req, res){
	if(req.session.displayName){
		res.send(`
				<h1>Hello , ${req.session.displayName}</h1>
				<a href="/auth/logout">Logout</a>
			`);
	}else{
		res.send(`
				<h1>Welcome</h1>
				<a href="/auth/login">Login</a>	
			`);
	}
	
})

app.get('/auth/logout', function(req, res){
	delete req.session.displayName;
	req.session.save(function(){
		res.redirect('/welcome');
	})
	
});

app.listen(3003, function(){
	console.log('connected 3003 port');
});