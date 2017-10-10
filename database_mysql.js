var mysql      = require('mysql');
var conn = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root!@#$',
  database : 'serversidejavascript'
});

conn.connect();
//var sql="select * from topic";
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
var params = ['qwe123','qwe123123123','asdasd21wdq'];
conn.query(sql, params, function(err, rows, fields){
	if(err){
		console.log(err);
	}else{
		console.log(rows);
	}
})



conn.end();