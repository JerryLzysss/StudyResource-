const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  lintOnSave:false,
  transpileDependencies: true,
  /* 提供支持编译template模板，解决在js中编译产生错误的问题 */
  runtimeCompiler: true
})
