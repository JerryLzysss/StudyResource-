import { createContext, useContext, useReducer, useState } from 'react';

const TasksContext = createContext(null);
const TasksDispatchContext = createContext(null);

function tasksReducer(tasks, action) {
  switch (action.type) {
    case 'added':
      return [...tasks, { id: action.id, text: action.text, done: false }];
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
  { id: 0, text: 'Philosopher’s Path', done: true },
  { id: 1, text: 'Visit the temple', done: false },
  { id: 2, text: 'Drink matcha', done: false },
];

function TaskList() {
  const tasks = useContext(TasksContext);
  const dispatch = useContext(TasksDispatchContext);

  return (
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
  );
}

function AddTask() {
  const [text, setText] = useState('');
  const dispatch = useContext(TasksDispatchContext);

  return (
    <div className="row">
      <input value={text} onChange={(e) => setText(e.target.value)} />
      <button
        type="button"
        onClick={() => {
          const value = text.trim();
          if (!value) return;
          dispatch({ type: 'added', id: nextId++, text: value });
          setText('');
        }}
      >
        Add
      </button>
    </div>
  );
}

export default function ReducerContextDemo() {
  const [tasks, dispatch] = useReducer(tasksReducer, initialTasks);

  return (
    <TasksContext.Provider value={tasks}>
      <TasksDispatchContext.Provider value={dispatch}>
        <section className="stack">
          <h3>Reducer + Context</h3>
          <p className="demo-note">
            深层组件通过 Context 读取 tasks / dispatch，无需层层传 props。
          </p>
          <AddTask />
          <TaskList />
        </section>
      </TasksDispatchContext.Provider>
    </TasksContext.Provider>
  );
}
