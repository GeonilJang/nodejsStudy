var express = require('express');
var app = express();
app.set('view engine', 'jade');
app.set('views','./views');
app.listen(3000, function(){
	console.log('connected 3000 port');
});

app.use(express.static('public'));


app.get('/template', function(req,res){
	res.render('temp');
})

app.get('/route', function(req, res){
	res.send('Hello Route<br> <img src="/Lighthouse.jpg">');
})

app.get('/', function(req, res){
	res.send('Hello world Page');
});

app.get('/dynamic', function(req, res){
	var lis='';
	var time = Date();
	for(var i =0 ; i<5 ; i++){
		lis = lis +  '<li>coding</li>';
	}
	var output = `
	<!DOCTYPE html>
	<html>
	<head>
		<title></title>
	</head>
	<body>
		this is hello world 123123123123!<br>
		<img src="/Lighthouse.jpg"> 
		<ul>
		${lis}
		</ul>
		${time}
	</body>
	</html>
	`
	res.send(output);
})

app.get('/login', function(req, res){
	res.send('Login please');
});

