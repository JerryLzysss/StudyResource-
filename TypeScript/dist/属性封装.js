class person3 {
    constructor(name, age, sex) {
        this.name = name;
        this.age = age;
        this.sex = sex;
    }
    getSex() {
        return this.sex;
    }
    setSex(sex) {
        this.sex = sex;
    }
}
const p = new person3('1', 1, 'male');
p.setSex('female');
