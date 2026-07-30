const people = [
  {
    id: 0,
    name: 'Creola Katherine Johnson',
    profession: 'mathematician',
    accomplishment: 'spaceflight calculations',
    imageId: 'MK3eW3A',
  },
  {
    id: 1,
    name: 'Mario José Molina-Pasquel Henríquez',
    profession: 'chemist',
    accomplishment: 'discovery of Arctic ozone hole',
    imageId: 'mynHUSa',
  },
  {
    id: 2,
    name: 'Mohammad Abdus Salam',
    profession: 'physicist',
    accomplishment: 'electromagnetism theory',
    imageId: 'bE7W1ji',
  },
];

function getImageUrl(person) {
  return (
    'https://react.dev/images/docs/scientists/' + person.imageId + 's.jpg'
  );
}

export default function RenderingListsDemo() {
  const listItems = people.map((person) => (
    <li key={person.id} className="list-item">
      <img src={getImageUrl(person)} alt={person.name} className="avatar" />
      <p>
        <b>{person.name}</b>
        {' — ' + person.profession}
        <br />
        known for {person.accomplishment}
      </p>
    </li>
  ));

  return (
    <article>
      <h3>Scientists</h3>
      <ul className="people-list">{listItems}</ul>
    </article>
  );
}
