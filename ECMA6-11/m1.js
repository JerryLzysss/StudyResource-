//分别暴露
export let school='1';
//默认暴露
export default{
    school:'2'
}

//统一暴露
let school='3';
export{school};