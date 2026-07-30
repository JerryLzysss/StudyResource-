import { useReducer, useState } from 'react';

function tasksReducer(tasks, action) {
  switch (action.type) {
    case 'added':
      return [
        ...tasks,
        { id: action.id, text: action.text, done: false },
      ];
    case 'changed':
      return tasks.map((t) => (t.id === action.task.id ? action.task : t));
    case 'deleted':
      return tasks.filter((t) => t.id !== action.id);
    default:
      throw new Error('Unknown action: ' + action.type);
  }
}

let nextId = 3;
const initialTasks = [
  { id: 0, text: 'Visit Kafka Museum', done: true },
  { id: 1, text: 'Watch a puppet show', done: false },
  { id: 2, text: 'Lennon Wall pic', done: false },
];

export default function ReducerDemo() {
  const [tasks, dispatch] = useReducer(tasksReducer, initialTasks);
  const [text, setText] = useState('');

  function handleAdd() {
    const value = text.trim();
    if (!value) return;
    dispatch({ type: 'added', id: nextId++, text: value });
    setText('');
  }

  return (
    <section className="stack">
      <h3>useReducer 任务列表</h3>
      <div className="row">
        <input value={text} onChange={(e) => setText(e.target.value)} />
        <button type="button" onClick={handleAdd}>
          Add
        </button>
      </div>
      <ul>
        {tasks.map((task) => (
          <li key={task.id} className="row">
            <label>
              <input
                type="checkbox"
                checked={task.done}
                onChange={(e) =>
                  dispatch({
                    type: 'changed',
                    task: { ...task, done: e.target.checked },
                  })
                }
              />{' '}
              {task.text}
            </label>
            <button
              type="button"
              onClick={() => dispatch({ type: 'deleted', id: task.id })}
            >
              Delete
            </button>
          </li>
        ))}
      </ul>
    </section>
  );
}
