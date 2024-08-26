const http=require('http');
const server=http.createServer((request,response)=>{
   let url=new URL(request.url,"http://127.0.0.1");
   console.log(url.pathname);
   console.log(url.searchParams.get('keyword'));
    response.end('url new');

});

server.listen(9000,()=>{
   
    console.log("OKSTART");
})