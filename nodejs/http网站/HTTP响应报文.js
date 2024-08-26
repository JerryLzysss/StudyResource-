const http=require('http');
const server=http.createServer((request,response)=>{
   response.statusCode=203;
   response.statusMessage='ggg';
   response.setHeader('server','node.js');
   response.write("aaa");
   response.end();

});

server.listen(9000,()=>{
   
    console.log("OKSTART");
})