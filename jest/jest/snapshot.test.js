const { createUser, renderLink } = require('./snapshot');

test('对象快照', () => {
  expect(createUser('Alice', 20)).toMatchSnapshot({
    createdAt: expect.any(Date),
    id: expect.any(Number),
  });
});

test('链接结构快照', () => {
  expect(renderLink('http://www.facebook.com', 'Facebook')).toMatchSnapshot();
});

test('内联快照', () => {
  expect({ ok: true, count: 2 }).toMatchInlineSnapshot(`
{
  "count": 2,
  "ok": true,
}
`);
});
