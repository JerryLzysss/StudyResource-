import { useState } from 'react';

const initialItems = [
  { title: 'pretzels', id: 0 },
  { title: 'crispy seaweed', id: 1 },
  { title: 'granola bar', id: 2 },
];

export default function ChoosingStructureDemo() {
  const [items, setItems] = useState(initialItems);
  const [selectedId, setSelectedId] = useState(0);
  const selectedItem = items.find((item) => item.id === selectedId);

  function handleChange(id, e) {
    setItems(
      items.map((item) =>
        item.id === id ? { ...item, title: e.target.value } : item
      )
    );
  }

  return (
    <section className="stack">
      <h3>选择 state 结构：用 id 而不是重复对象</h3>
      <ul>
        {items.map((item) => (
          <li key={item.id} className="row">
            <input
              value={item.title}
              onChange={(e) => handleChange(item.id, e)}
            />
            <button type="button" onClick={() => setSelectedId(item.id)}>
              Choose
            </button>
          </li>
        ))}
      </ul>
      <p>
        你选中了 <b>{selectedItem.title}</b>
      </p>
    </section>
  );
}
