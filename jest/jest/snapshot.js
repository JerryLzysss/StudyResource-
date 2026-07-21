function createUser(name, age) {
  return {
    name,
    age,
    createdAt: new Date('2020-01-01'),
    id: 1,
  };
}

function renderLink(page, text) {
  return {
    type: 'a',
    props: {
      href: page,
      children: text,
    },
  };
}

module.exports = { createUser, renderLink };
