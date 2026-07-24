const fs=require('fs');
const http=require('http');
const path=require('path');



/* 
超文本标记语言文本	.html , .htm text/html
普通文本	.txt text/plain
RTF 文本	.rtf application/rtf
GIF 图形	.gif image/gif
JPEG 图	.jpeg,.jpg image/jpeg
au 声音文	.au audio/basic
MIDI 音乐文件	mid,.midi audio/midi,audio/x-midi
RealAudio 音乐文	.ra, .ram audio/x-pn-realaudio
MPEG 文	.mpg,.mpeg video/mpeg
AVI 文	.avi video/x-msvideo
GZIP 文	.gz application/x-gzip
TAR 文件	.tar application/x-tar
 */
let mimes={
    html:'text/html',
    css:'text/css',
    js:'application/javascript',
    png:'image/png',
    jpg:'image/jpeg',
    jpeg:'image/jpeg',
    gif:'image/gif',
    mp3:'audio/mpeg',
    mp4:'video/mp4',
    json:'application/json'
}


const server=http.createServer((request,response)=>{
   let {pathname}=new URL(request.url,'http://127.0.0.1');
   let root=__dirname;
   let filePath=root+pathname;
    fs.readFile(filePath,(err,data)=>{
        if(err)
        {
            
            response.statusCode=500;
            response.end(filePath);
            return ;
        }
        let ext=path.extname(filePath).slice(1);
        let type=mimes[ext];
        if(type)
        {
            // 文本类型补充 charset，避免中文乱码
            if(type.startsWith('text/') || type === 'application/javascript' || type === 'application/json')
            {
                response.setHeader('content-type', type + '; charset=UTF-8');
            }
            else
            {
                response.setHeader('content-type', type);
            }
        }
        else
        {
            response.setHeader('content-type','application/octet-stream');
        }
        response.end(data);
    })
});

server.listen(9000,()=>{
   
    console.log("OKSTART");
})

/*  */
