const person = {
  name: 'Gregorio Y. Zara',
  theme: {
    backgroundColor: '#111',
    color: '#ff8fab',
    padding: '16px',
    borderRadius: '8px',
  },
};

export default function CurlyBracesDemo() {
  return (
    <div style={person.theme}>
      <h3>{person.name}&apos;s Todos</h3>
      <img
        className="avatar"
        src="https://react.dev/images/docs/scientists/7vQD0fPs.jpg"
        alt={person.name}
      />
      <ul>
        <li>Improve the videophone</li>
        <li>Prepare aeronautics lectures</li>
        <li>Work on the alcohol-fuelled engine</li>
      </ul>
    </div>
  );
}
