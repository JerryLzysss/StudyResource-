import { useState } from 'react';

const sculptureList = [
  {
    name: 'Homenaje a la Neurocirugía',
    artist: 'Marta Colvin Andrade',
    description:
      'Although Colvin is predominantly known for abstract themes...',
    url: 'https://i.imgur.com/Mx7dA2Y.jpg',
    alt: 'A bronze statue of two crossed hands delicately holding a human brain.',
  },
  {
    name: 'Floralis Genérica',
    artist: 'Eduardo Catalano',
    description:
      'This enormous flower is made of stainless steel and aluminum...',
    url: 'https://i.imgur.com/ZF6s192.jpg',
    alt: 'A gigantic metallic flower sculpture with reflective petals.',
  },
  {
    name: 'Eternal Presence',
    artist: 'John Woodrow Wilson',
    description: 'Wilson was known for his preoccupation with equality...',
    url: 'https://i.imgur.com/aTtVpES.jpg',
    alt: 'A sculpture of a human head with closed eyes.',
  },
];

export default function StateMemoryDemo() {
  const [index, setIndex] = useState(0);
  const [showMore, setShowMore] = useState(false);
  const sculpture = sculptureList[index];

  return (
    <section>
      <button
        type="button"
        onClick={() => setIndex((i) => (i + 1) % sculptureList.length)}
      >
        Next
      </button>
      <h3>
        <i>{sculpture.name}</i> by {sculpture.artist}
      </h3>
      <h4>
        ({index + 1} of {sculptureList.length})
      </h4>
      <button type="button" onClick={() => setShowMore((v) => !v)}>
        {showMore ? 'Hide' : 'Show'} details
      </button>
      {showMore && <p>{sculpture.description}</p>}
      <img src={sculpture.url} alt={sculpture.alt} className="sculpture" />
    </section>
  );
}
