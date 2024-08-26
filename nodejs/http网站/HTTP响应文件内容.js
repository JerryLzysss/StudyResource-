const fs=require('fs');
const http=require('http');
const server=http.createServer((request,response)=>{
    let htmls=fs.readFileSync(__dirname+'/HTTP建立.html');
    response.end(htmls);
});

server.listen(9000,()=>{
   
    console.log("OKSTART");
})