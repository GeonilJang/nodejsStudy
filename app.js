var express = require('express');
var badyParser = require('body-parser');

const hostname = '127.0.0.1';
var app = express();
app.listen(3000, function(){
	console.log('connected 3000 port');
});

app.use(badyParser.urlencoded({ extended: false}));
app.use(express.static('public'));
app.set('view engine', 'jade');
app.set('views','./views');








app.get('/form', function(req, res){

	res.render('form');


})


app.post('/form_receiver', function(req,res){
	var title = req.body.title;
	var description = req.body.description;
	res.send(title+', '+description);
})

app.get('/form_receiver', function(req, res){
	var title = req.query.title;
	var description = req.query.description;
	res.send(title+', '+description);
})



app.get('/template', function(req,res){
	res.render('temp.jade', {time:Date(), _title:"Jade"});
})

app.get('/route', function(req, res){
	res.send('Hello Route<br> <img src="/Lighthouse.jpg">');
})

app.get('/topic/:id' ,function(req, res){

	var topic = ['javascript is..11.', 'NodeJs is ..11.', 'Express is ...'];
	var name =['first', 'second', 'third'];
	var na;
	var str = `
			<a href="/topic/0">JavaScript</a><br>
			<a href="/topic/1">Nodejs</a><br>
			<a href="/topic/2">Express</a><br><br>
			${topic[req.params.id]}
			
	`
	res.send(str);
})

app.get('/topic/:id/:mode', function(req, res){
	res.send(req.params.id+', '+req.params.mode);
})




app.get('/', function(req, res){
	res.send('Hello world Page123123123');
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

