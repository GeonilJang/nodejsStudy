var express = require('express');
var badyParser = require('body-parser');
var fs = require('fs');

var app = express();
app.listen(3000, function(){
	console.log('Connected 3000 port');
})

var mysql = require('mysql');
var conn = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root!@#$',
  database : 'serversidejavascript'
});

conn.connect();

app.use(badyParser.urlencoded({ extended: false}));
app.locals.pretty = true;

app.set('view engine', 'jade');
app.set('views','./views_mysql');





app.get('/topic/add', function(req, res){
	var sql = 'select id, title from topic';
	conn.query(sql, function(err, topics, fields){
		res.render('add', {topics:topics});

	});
// 	fs.readdir('data',function(err, files){
// 		if(err){
// 			console.log(err);
// 			res.status(500).send('Internal Server Error'); //파일시스템을 이용한 데이터 저장
// 		}
// 			res.render('add', {topics:files});
// })
})

app.post('/topic/add', function(req, res){

	var title = req.body.title;
	var description= req.body.description;
	var author= req.body.author;
	var sql ='INSERT INTO topic (title, description, author) values(?, ?, ?)';

	conn.query(sql, [title, description, author], function(err, result, fields){
		if(err){
			console.log(err);
			res.status(500).send('Internal Server Error');
		}else{
			res.redirect('/topic/'+result.INSERTID);
		}
	});
});






app.post('/topic', function(req, res){

	var title = req.body.title;
	var description= req.body.description;
	fs.writeFile('data/'+title,description,function(err){
		if(err){
			res.status(500).send('Internal Server Error');
		}else{
			res.redirect('/topic/'+title);
		}
	})
})

app.get(['/topic','/topic/:id'], function(req, res){

	var sql = 'select id, title from topic';
	conn.query(sql, function(err, topics, fields){
		var id = req.params.id;
		if(id){
			var sql = 'select * from topic where id = ?'
			conn.query(sql, [id], function(err, topic, fileds){
				if(err){
					res.status(500).send('Internal Server Error');
					console.log(err);
				}else{
					res.render('view', {topics:topics, topic:topic[0]});
				}
			});
		}else{
			res.render('view', {topics:topics});	
		}
		
	});

})
	

	/*
	fs.readdir('data',function(err, files){
		if(err){
			console.log(err);
			res.status(500).send('Internal Server Error');
		}else{
			var id = req.params.id;
			if(id){
				fs.readFile('data/'+id, 'utf8', function(err, data){
					if(err){
						console.log(err);
						res.status(500).send('Internal Server Error');
					}else{
						res.render('view', {topics:files, title:id, description:data})	
					}
				})	
			}else{
				res.render('view', {topics:files, title:'Welcome', description:'Hello, Javascript for server'});
			}		
		}
	})	
})
*/
// app.get('/topic/:id', function(req, res){
// 	var id = req.params.id;

// 	fs.readdir('data/',function(err, files){
// 		if(err){
// 			console.log(err);
// 			res.status(500).send('Internal Server Error');
// 		}
// 		fs.readFile('data/'+id, 'utf8', function(err, data){
// 		if(err){
// 			console.log(err);
// 			res.status(500).send('Internal Server Error');
// 		}else{
// 			res.render('view', {topics:files, title:id, description:data})
			
// 		}
// 	})	
// 	});
	
// })




