var express = require('express');
var app = express();
app.listen(3000, function(){
	console.log('connected 3000 port');
});

app.get('/', function(req, res){
	res.send('Hello world Page');
});

app.get('/login', function(req, res){
	res.send('Login please');
});

