import { useState } from 'react';

export default function QueueingUpdatesDemo() {
  const [number, setNumber] = useState(0);

  return (
    <section className="stack">
      <h3>{number}</h3>
      <button
        type="button"
        onClick={() => {
          setNumber((n) => n + 1);
          setNumber((n) => n + 1);
          setNumber((n) => n + 1);
        }}
      >
        +3（使用 updater 函数，真正 +3）
      </button>
      <button type="button" onClick={() => setNumber(0)}>
        重置
      </button>
    </section>
  );
}
