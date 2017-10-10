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


app.get(['/topic/:id/edit'], function(req, res){
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
					res.render('edit', {topics:topics, topic:topic[0]});
				}
			});
		}else{
			res.render('view', {topics:topics});
			res.status(500).send('this is no id');	
		}
		
	});

})


app.post(['/topic/:id/edit'], function(req, res){
	var title = req.body.title;
	var description = req.body.description;
	var author = req.body.author;
	var id = req.params.id;
	var sql = 'update topic set title=?, description=?, author=? where id=?'
	conn.query(sql, [title, description, author, id], function(err, result, fields){
		if(err){
			res.status(500).send('Internal Server Error');
			console.log(err);
		}else{
			res.redirect('/topic/'+id);
		}
	})

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


app.get(['/topic/:id/delete'], function(req, res){
	var sql = 'select id, title from topic';
	var id = req.params.id;
	conn.query(sql, function(err, topics, fields){
		var sql = 'select * from topic where id = ?';
		conn.query(sql, [id], function(err, topic){
			if(err){
				res.status(500).send('Internal Server Error');
				console.log(err);
			}else{
				if(topic.length === 0){
					res.status(500).send('Internal Server Error');
					console.log(err);
				}else{
					res.render('delete', {topics:topics, topic:topic[0]});
				}

				
				
			}
		})
		
	});
	

});


app.post(['/topic/:id/delete'], function(req, res){
	var id = req.params.id;
	var sql = 'delete from topic where id = ?';
	conn.query(sql, [id], function(err, result){
		if(err){
			res.status(500).send('Internal Server Error');
			console.log(err);
		}else{
			res.redirect('/topic/');
		}


	});
});
	

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




