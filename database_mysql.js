var mysql      = require('mysql');
var conn = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root!@#$',
  database : 'serversidejavascript'
});

conn.connect();
/*var sql="select * from topic";
// conn.query(sql, function(err, rows, fields){

// 	if(err){
// 		console.log(err);
// 	}else{
// 		for(var i = 0 ; i < rows.length; i++){
// 			console.log(rows[i].author);
// 		}
// 	}

// });

var sql = "insert into topic values(0,?,?,?)";
var params = ['express','helping make web','GEONIL'];
conn.query(sql, params, function(err, rows, fields){
	if(err){
		console.log(err);
	}else{
		console.log(rows.insertId);
	}
})



var sql = "update topic set title=?, author=? where id=?";
var params = ['geonil','GEONIL_JANG','3'];
conn.query(sql, params, function(err, rows, fields){
	if(err){
		console.log(err);
	}else{
		console.log(rows);
	}
})

*/

var sql = 'delete from topic where id = ?';
var params = [3];
conn.query(sql, params, function(err, rows, fields){
	if(err){
		console.log(err);
	}else{
		console.log(rows);
	}
})

conn.end();