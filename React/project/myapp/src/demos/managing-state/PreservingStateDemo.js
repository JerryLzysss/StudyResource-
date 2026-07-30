import { useState } from 'react';

function Counter({ label }) {
  const [score, setScore] = useState(0);
  return (
    <div className="panel">
      <h4>
        {label}: {score}
      </h4>
      <button type="button" onClick={() => setScore((s) => s + 1)}>
        +1
      </button>
    </div>
  );
}

export default function PreservingStateDemo() {
  const [isPlayerA, setIsPlayerA] = useState(true);

  return (
    <section className="stack">
      <h3>保留 / 重置 state</h3>
      <p className="demo-note">
        切换玩家时通过不同的 <code>key</code> 重置计数；去掉 key 则会保留。
      </p>
      {isPlayerA ? (
        <Counter key="Taylor" label="Taylor" />
      ) : (
        <Counter key="Sarah" label="Sarah" />
      )}
      <button type="button" onClick={() => setIsPlayerA((v) => !v)}>
        Next player
      </button>
    </section>
  );
}
