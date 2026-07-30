import { useState } from 'react';

export default function StateSnapshotDemo() {
  const [number, setNumber] = useState(0);
  const [log, setLog] = useState([]);

  function handleClick() {
    setNumber(number + 1);
    setNumber(number + 1);
    setNumber(number + 1);
    setLog((prev) => [
      ...prev,
      `三次 setNumber(number + 1)，但 number 快照仍是 ${number}，所以最终只 +1`,
    ]);
  }

  return (
    <section className="stack">
      <h3>{number}</h3>
      <button type="button" onClick={handleClick}>
        +3（基于快照，实际只 +1）
      </button>
      <ul>
        {log.slice(-5).map((item, i) => (
          <li key={i}>{item}</li>
        ))}
      </ul>
    </section>
  );
}
