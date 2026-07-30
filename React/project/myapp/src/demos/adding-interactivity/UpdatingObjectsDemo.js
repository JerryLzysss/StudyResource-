import { useState } from 'react';

export default function UpdatingObjectsDemo() {
  const [person, setPerson] = useState({
    name: 'Niki de Saint Phalle',
    artwork: {
      title: 'Blue Nana',
      city: 'Hamburg',
      image: 'https://i.imgur.com/Sd1AgUOm.jpg',
    },
  });

  function handleNameChange(e) {
    setPerson({
      ...person,
      name: e.target.value,
    });
  }

  function handleTitleChange(e) {
    setPerson({
      ...person,
      artwork: {
        ...person.artwork,
        title: e.target.value,
      },
    });
  }

  function handleCityChange(e) {
    setPerson({
      ...person,
      artwork: {
        ...person.artwork,
        city: e.target.value,
      },
    });
  }

  return (
    <section className="stack form-demo">
      <label>
        Name:{' '}
        <input value={person.name} onChange={handleNameChange} />
      </label>
      <label>
        Title:{' '}
        <input value={person.artwork.title} onChange={handleTitleChange} />
      </label>
      <label>
        City:{' '}
        <input value={person.artwork.city} onChange={handleCityChange} />
      </label>
      <p>
        <i>{person.artwork.title}</i> by {person.name}
        <br />
        (located in {person.artwork.city})
      </p>
      <img src={person.artwork.image} alt={person.artwork.title} className="sculpture" />
    </section>
  );
}
