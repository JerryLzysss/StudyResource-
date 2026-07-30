import { useState } from 'react';

function Panel({ title, children, isActive, onShow }) {
  return (
    <section className="panel">
      <h3>{title}</h3>
      {isActive ? (
        <p>{children}</p>
      ) : (
        <button type="button" onClick={onShow}>
          Show
        </button>
      )}
    </section>
  );
}

export default function SharingStateDemo() {
  const [activeIndex, setActiveIndex] = useState(0);

  return (
    <section>
      <h3>共享状态：手风琴（同一时间只展开一项）</h3>
      <Panel
        title="About"
        isActive={activeIndex === 0}
        onShow={() => setActiveIndex(0)}
      >
        With a population of about 2 million, Almaty is Kazakhstan&apos;s
        largest city.
      </Panel>
      <Panel
        title="Etymology"
        isActive={activeIndex === 1}
        onShow={() => setActiveIndex(1)}
      >
        The name comes from &quot;alma&quot;, the Kazakh word for
        &quot;apple&quot;.
      </Panel>
    </section>
  );
}
