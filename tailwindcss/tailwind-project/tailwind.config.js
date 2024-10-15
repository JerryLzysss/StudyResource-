/*
 * @Description: 
 */

///** @type {import('tailwindcss').Config} */
module.exports = {
  // content表示应用tailwind的文件
  content: ['./**/*.{html, js}'],
  //theme: {
    // 如果直接设置样式就会进行覆盖
    //   colors: {
    //   blue: '#1fb6ff',
    //   purple: '#7e5bef',
    //   pink: '#ff49db',
    //   orange: '#ff7849',
    //   green: '#13ce66',
    //   yellow: '#ffc82c',
    //   'gray-dark': '#273444',
    //   gray: '#8492a6',
    //   'gray-light': '#d3dce6',
    // },


    // extend表示用来追加所需颜色
  //  extend: {
      // colors: {
      //   'primary-dark': '#1f2937',
      //   'primary-light': '#f3f4f6',
      //   'secondary-dark': '#1f2937',
      //   'secondary-light':'#f3f4f6'
      // }
   // },
    
 // },
  // plugins通过自定义插件拓展tailwind功能
  //plugins: [
    //postcss-nesting(tailwind嵌套)


    // 通过插件编写添加基础样式
    // plugin(function ({ addBase, theme }) {
    //   addBase({
    //     'h1': { fontSize: theme('fontSize.2xl') },
    //     'h2': { fontSize: theme('fontSize.xl') },
    //     'h3': { fontSize:theme('fontSize.lg')},
    //   })
    // })

      // 通过插件编写添加组件
    // plugin(function ({ addComponents, theme }){
    //   const buttons = {
    //     '.btn': {
    //       padding: `${theme('spacing.2')}${theme('spacing.4')}`,
    //       borderRadius: theme('borderRadius.md'),
    //       fontWeight: this.theme('fontWeight.600'),
    //       '&:hover': {
    //         backgroundColor:theme('colors.blue.600')
    //       }
    //     }
    //   }
    // })

    //通过插件编写添加功能类
    // plugin(function ({ addUtilities }) {
    //   const newUtilities = {
    //     '.filter-none': { filter: 'none' },
    //     '.filter-grayscale': { filter: 'grayscale(100%)' },
        
    //   }
    //   addUtilities(newUtilities,['responsive','hover'])
    // })
 // ],
  //presets通过自定义预设样式，多个项目共享一套配置 
  //presets: [{
    
  //}],
  //prefix:未所有tailwind生成的utilities类添加前缀，避免命名冲突
 // prefix: [{
    
 // }],
  // important:配置所有utilities类为!important以确保它们优先应用
 // important: [{
    
 // }],
  // corePlugins：禁用不想使用的样式，减少CSS体积
  //corePlugins: [{
    
  //}]
}

