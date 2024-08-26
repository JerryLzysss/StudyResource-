var express=require('express');

var router=express.Router();

router.get('/account',function(req,res,next){
res.send('账本列表');
});
router.get('/account/create',function(req,res,next){
res.send('添加记录');
});

module.exports=router;