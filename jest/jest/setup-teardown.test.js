let cities = [];

function initializeCityDatabase() {
  cities = ['Vienna', 'San Juan'];
}

function clearCityDatabase() {
  cities = [];
}

function isCity(name) {
  return cities.includes(name);
}

beforeEach(() => {
  initializeCityDatabase();
});

afterEach(() => {
  clearCityDatabase();
});

test('city database has Vienna', () => {
  expect(isCity('Vienna')).toBeTruthy();
});

test('city database has San Juan', () => {
  expect(isCity('San Juan')).toBeTruthy();
});

describe('嵌套作用域', () => {
  let food = [];

  beforeEach(() => {
    food = ['奶茶'];
  });

  test('内层 beforeEach 会叠加外层', () => {
    expect(isCity('Vienna')).toBeTruthy();
    expect(food).toContain('奶茶');
  });
});
