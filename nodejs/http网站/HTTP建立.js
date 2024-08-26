const http=require('http');
const server=http.createServer((request,response)=>{
    let body=' ';
    response.setHeader('content-type','text/html;charset=utf-8');

    request.on('data',chunk=>{
        body+=chunk;
    })
    request.on('end',()=>{
        console.log(body);
        response.end('http');
    })

});

server.listen(9000,()=>{
   
    console.log("OKSTART");
})