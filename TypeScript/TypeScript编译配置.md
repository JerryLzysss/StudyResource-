# Typescript 配置

默认情况下 只通过执行tsc xxx.ts其生成目录与当前目录相同。
如果需要配置一些其他特性，那么需要在当前目录下创建tsconfig.json进行配置。

# 简易模板
```
//通过当前配置可以将生成文件放入dist目录
{
    "compilerOptions": {
        "module":"ES2015",
        "target":"ES2015",
        "outDir":"./dist"
    },
    "include": [
        "./*"
    ]
}
```

# 模板详解
```
{
    /* 配置文件写于大括号内 *
    /* 对cmd使用tsc默认编译所有 */

    /* include:指定哪些TS需要被编译 */
    "include":[
        "./*"
    ],
    /* exclude指定哪些TS不需要被编译
    具有默认值:node_modules,bower_composition,jspm_package */
    "exclude":[
      "./04-2/*"
    ],
    /* 指定要求继承的配置文件
    例如./configs/base 会自动包含base.json下所有的配置信息 */
    "extends":[

    ],
    /* 指定被编译的文件 */
    "files":[
        
    ],
    "compilerOptions": {
        /* 指定被编译为ES的版本,默认为ES3, */
        "target":"ES6",
        /* module指定模块化的规范 */
        "module":"none",
        /* lib用来指定要用的库，其指定是一个数组 */
        "lib":["DOM"],
        /* outDir用来指定编译后的文件所在目录 */
        "outDir": "./dist",
        /* outFile用来合并文件 */
        /* ""outFile":./dist/app.js" */
        /* allowJs:是否对js文件进行编译，默认为false */
        "allowJs":true,
        /* 是否检查JS代码是否符合语法规范，默认为false */
        "checkJs":true,
        /* 是否移除注释 */
        "removeComments": false,
        /* 是否生成编译后的文件 */
        "noEmit":false,
        /* 当有编译错误的时候不生成编译后文件 */
        "noEmitOnError": true,
        /* alwaysStrict用来设置编译后的文件是否为严格模式，默认为false */
        "alwaysStrict": false,
        /* 设置是否允许隐式any */
        "noImplicitAny": false,
        /* 是否允许不明确类型的this */
        "noImplicitThis": false,
        /* 严格检查空值 */
        "strictNullChecks": false,
        /* 是否所有严格进行开关 */
        "strict":false
    }
    /*  */

}
```