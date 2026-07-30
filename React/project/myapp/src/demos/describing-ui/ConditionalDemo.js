function Item({ name, isPacked }) {
  return (
    <li>
      {name} {isPacked && '✅'}
      {!isPacked && '❌'}
    </li>
  );
}

export default function ConditionalDemo() {
  return (
    <section>
      <h3>Sally Ride&apos;s Packing List</h3>
      <ul>
        <Item isPacked={true} name="Space suit" />
        <Item isPacked={true} name="Helmet with a golden leaf" />
        <Item isPacked={false} name="Photo of Tam" />
      </ul>
    </section>
  );
}
