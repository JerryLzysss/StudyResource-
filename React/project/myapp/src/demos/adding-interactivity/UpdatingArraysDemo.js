import { useState } from 'react';

let nextId = 3;
const initialList = [
  { id: 0, title: 'Big Bellies', seen: false },
  { id: 1, title: 'Lunar Landscape', seen: false },
  { id: 2, title: 'Terracotta Army', seen: true },
];

export default function UpdatingArraysDemo() {
  const [list, setList] = useState(initialList);
  const [text, setText] = useState('');

  function handleAdd() {
    const title = text.trim();
    if (!title) return;
    setList([...list, { id: nextId++, title, seen: false }]);
    setText('');
  }

  function handleToggle(id) {
    setList(
      list.map((item) =>
        item.id === id ? { ...item, seen: !item.seen } : item
      )
    );
  }

  function handleDelete(id) {
    setList(list.filter((item) => item.id !== id));
  }

  return (
    <section className="stack">
      <div className="row">
        <input
          value={text}
          onChange={(e) => setText(e.target.value)}
          placeholder="新艺术品"
        />
        <button type="button" onClick={handleAdd}>
          添加
        </button>
      </div>
      <ul>
        {list.map((item) => (
          <li key={item.id} className="row">
            <label>
              <input
                type="checkbox"
                checked={item.seen}
                onChange={() => handleToggle(item.id)}
              />{' '}
              {item.title}
            </label>
            <button type="button" onClick={() => handleDelete(item.id)}>
              删除
            </button>
          </li>
        ))}
      </ul>
    </section>
  );
}
